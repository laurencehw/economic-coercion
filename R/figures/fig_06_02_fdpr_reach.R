# Figure 6.2: Foreign Direct Product Rule (FDPR) Extraterritorial Reach
# Chapter 6: Trade Controls
# Visualizes how US export controls reach globally through FDPR

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)
library(forcats)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Define FDPR affected entities by country
fdpr_exposure <- data.frame(
  country = c(
    "Taiwan", "South Korea", "Japan", "Netherlands", "Germany",
    "United Kingdom", "China", "Singapore", "Malaysia", "Israel",
    "Ireland", "France", "Italy", "Canada", "Australia"
  ),
  exposure_level = c(
    "Critical", "Critical", "High", "Critical", "High",
    "High", "Target", "Medium", "Medium", "High",
    "Medium", "Medium", "Medium", "Medium", "Medium"
  ),
  key_companies = c(
    "TSMC", "Samsung, SK Hynix", "Tokyo Electron, Nikon", "ASML", "Infineon, Zeiss",
    "ARM", "Huawei, SMIC (targets)", "GlobalFoundries", "Intel, Micron fabs", "Intel",
    "Intel", "STMicro", "STMicro", "Foundries", "None major"
  ),
  semiconductor_role = c(
    "Manufacturing", "Manufacturing", "Equipment", "Equipment", "Equipment",
    "Design IP", "End user (restricted)", "Manufacturing", "Assembly", "Design",
    "Manufacturing", "Design/Mfg", "Design", "Minor", "Minor"
  ),
  us_tech_dependency = c(95, 85, 60, 80, 55, 70, 40, 75, 70, 80, 85, 50, 50, 60, 40)
)

# Map country names
country_mapping <- c(
  "United Kingdom" = "United Kingdom",
  "South Korea" = "Republic of Korea"
)

fdpr_exposure$country_mapped <- ifelse(
  fdpr_exposure$country %in% names(country_mapping),
  country_mapping[fdpr_exposure$country],
  fdpr_exposure$country
)

# Get world map
world <- ne_countries(scale = "medium", returnclass = "sf")

# Merge data
world_fdpr <- world %>%
  left_join(fdpr_exposure, by = c("name" = "country_mapped"))

# Define colors
exposure_colors <- c(
  "Critical" = "#d62728",
  "High" = "#ff7f0e",
  "Medium" = "#ffbb78",
  "Target" = "#1f77b4",
  "None" = "#e0e0e0"
)

# Set factor levels
world_fdpr$exposure_level <- factor(
  world_fdpr$exposure_level,
  levels = c("Target", "Critical", "High", "Medium", "None")
)

# Create the map
p1 <- ggplot(world_fdpr) +
  geom_sf(aes(fill = exposure_level), color = "white", linewidth = 0.2) +
  scale_fill_manual(
    values = exposure_colors,
    name = "FDPR Exposure",
    na.value = "#e0e0e0",
    labels = c("Target" = "Restricted Target (China)",
               "Critical" = "Critical (Major fabs/equipment)",
               "High" = "High (Key suppliers)",
               "Medium" = "Medium (Some exposure)",
               "None" = "Minimal/None")
  ) +
  coord_sf(crs = "+proj=robin") +
  labs(
    title = "Foreign Direct Product Rule: Global Reach",
    subtitle = "How US export controls extend extraterritorially through technology dependencies"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "right"
  )

# Bar chart of US technology dependency
dep_chart <- fdpr_exposure %>%
  filter(exposure_level != "Target") %>%
  mutate(country = fct_reorder(country, us_tech_dependency))

p2 <- ggplot(dep_chart, aes(x = country, y = us_tech_dependency, fill = exposure_level)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(us_tech_dependency, "%")), hjust = -0.1, size = 3.5) +
  coord_flip() +
  scale_fill_manual(values = exposure_colors, guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "US Technology Dependency in Semiconductor Production",
    subtitle = "Estimated share of production requiring US-origin technology",
    x = NULL,
    y = "US Technology Dependency (%)",
    caption = "Source: BIS, SIA, industry analysis\nNote: FDPR applies when products are made using US-origin software, technology, or equipment"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.y = element_blank())

# Combine
library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(1.3, 1))

# Save the figure
save_econ_figure("figures/fig_06_02_fdpr_reach.png", plot = combined, width = 12, height = 12)

cat("Figure 6.2 created: FDPR Extraterritorial Reach\n")
