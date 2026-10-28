# Figure 7.3: OFAC enforcement settlements, 2006-2026
# Purpose: Show how large OFAC civil penalties and settlements are, and how lumpy.
# Data: data/sources/ofac_settlements_150m.csv and data/sources/ofac_penalties_by_year.csv, written by
#       scripts/fetch_ofac_penalties.py from OFAC's "Civil Penalties and Enforcement Information" year pages.
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(patchwork)
library(scales)

source(here("R", "setup_theme.R"))

# ============================================================================
# 1. LOAD DATA (committed extracts; refresh with scripts/fetch_ofac_penalties.py)
# ============================================================================

big <- read.csv(here("data", "sources", "ofac_settlements_150m.csv"), stringsAsFactors = FALSE, encoding = "UTF-8") %>%
  mutate(year = as.integer(substr(date, 1, 4)))
by_year <- read.csv(here("data", "sources", "ofac_penalties_by_year.csv"), stringsAsFactors = FALSE, encoding = "UTF-8")

# A transcription slip in either extract fails the build.
stopifnot(
  abs(sum(by_year$total_usd) - 7917367316.85) < 0.01,   # OFAC totals 2006 to 27 Oct 2026, retrieved 2026-10-28
  nrow(big) == 15,
  all(big$amount_usd >= 150e6),
  all(big %>% group_by(year) %>% summarise(s = sum(amount_usd)) %>%
        left_join(by_year, by = "year") %>% transmute(ok = s <= total_usd) %>% pull(ok))
)

# Short labels, matched on an ASCII fragment of the OFAC name (robust to the Windows/Linux locale difference).
short_names <- c(
  "Lloyds" = "Lloyds", "Credit Suisse" = "Credit Suisse", "Barclays" = "Barclays", "ING Bank" = "ING",
  "HSBC" = "HSBC", "Clearstream" = "Clearstream", "BNP Paribas" = "BNP Paribas", "Commerzbank" = "Commerzbank",
  "Agricole" = "Cr\u00e9dit Agricole CIB", "Standard Chartered" = "Standard Chartered", "UniCredit" = "UniCredit",
  "British American Tobacco" = "British American Tobacco", "Binance" = "Binance",
  "GVA Capital" = "GVA Capital", "Adani" = "Adani Enterprises")
shorten <- function(x) vapply(x, function(e) {
  hit <- names(short_names)[vapply(names(short_names), function(k) grepl(k, e, fixed = TRUE), logical(1))]
  stopifnot(length(hit) == 1)
  unname(short_names[hit])
}, character(1), USE.NAMES = FALSE)
big <- big %>% mutate(short = shorten(entity))

# ============================================================================
# 2. PANEL A: SETTLEMENTS OF $150 MILLION OR MORE
# ============================================================================

pa <- big %>%
  mutate(label = paste0(short, " (", year, ")"),
         sector = factor(if_else(sector == "bank", "Banks", "Other firms"), levels = c("Banks", "Other firms")),
         value_lab = paste0("$", round(amount_usd / 1e6), "M")) %>%
  arrange(amount_usd) %>%
  mutate(label = factor(label, levels = label))

p1 <- ggplot(pa, aes(x = amount_usd / 1e6, y = label, fill = sector)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = value_lab), hjust = -0.15, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_fill_manual(values = c("Banks" = lws_colors[["red"]], "Other firms" = lws_colors[["fade"]])) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.15)), labels = label_dollar(suffix = "M"),
                     breaks = seq(0, 1000, 250)) +
  labs(title = "A. OFAC settlements of $150 million or more, by firm and year",
       x = "OFAC settlement amount (millions of US dollars)", y = NULL) +
  theme_book_h() +
  theme(legend.position = "top")

# ============================================================================
# 3. PANEL B: ALL OFAC PENALTIES AND SETTLEMENTS, BY YEAR
# ============================================================================

# Label the largest settlement in each year with a total of $0.7 billion or more.
peaks <- big %>%
  group_by(year) %>%
  slice_max(amount_usd, n = 1) %>%
  ungroup() %>%
  select(year, lab = short)

pb <- by_year %>%
  left_join(peaks, by = "year") %>%
  mutate(bn = total_usd / 1e9,
         lab = if_else(!is.na(lab) & bn >= 0.7, lab, NA_character_),
         fill = if_else(partial_year, "partial", "full"),
         lab = gsub(" ", "\n", lab))

p2 <- ggplot(pb, aes(x = year, y = bn, fill = fill)) +
  geom_col(width = 0.75) +
  geom_text(aes(label = lab), vjust = -0.25, lineheight = 0.9, colour = lws_colors[["ink"]],
            size = book_text_size) +
  scale_fill_manual(values = c(full = lws_colors[["blue"]], partial = lws_colors[["fade"]]), guide = "none") +
  scale_x_continuous(breaks = seq(2006, 2026, 4), limits = c(2005.3, 2026.7)) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.2)), labels = label_dollar(suffix = "B"),
                     breaks = seq(0, 1.5, 0.5)) +
  labs(title = "B. All OFAC civil penalties and settlements, by year (billions of US dollars)",
       x = NULL, y = NULL) +
  theme_lws()

combined <- p1 / p2 + plot_layout(heights = c(1.35, 1)) +
  plot_annotation(
    caption = paste(strwrap(paste(
      "Source: U.S. Treasury, Office of Foreign Assets Control, Civil Penalties and Enforcement Information (year pages, retrieved 28 October 2026).",
      "OFAC's own settlement amounts only: larger global resolutions that also involved the Justice Department, the Federal Reserve or state regulators are not shown.",
      "Panel B sums every penalty and settlement OFAC lists for the year and names the largest settlement in years above $0.7 billion; the grey bar, 2026, runs to 27 October."), 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here("figures", "fig_07_03_sanctions_programs.png"), combined, width = 6, height = 6.2)

cat("\nFigure 7.3 summary:\n")
cat(sprintf("  OFAC penalties and settlements 2006-2026: $%.2f billion\n", sum(by_year$total_usd) / 1e9))
cat(sprintf("  %d settlements at or above $150 million, of which %d with banks (%.0f%% of their value)\n",
            nrow(big), sum(big$sector == "bank"),
            100 * sum(big$amount_usd[big$sector == "bank"]) / sum(big$amount_usd)))
