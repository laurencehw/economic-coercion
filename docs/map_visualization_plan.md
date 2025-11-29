# Geographic Visualization Plan

## Current Status

### Existing Map Scripts (R/figures/)
| Script | Status | Uses tmap? |
|--------|--------|------------|
| fig_03_04_chokepoints.R | Output generated, not in chapter | No (ggplot2/sf) |
| fig_03_05_subsea_cables.R | Script only, no output | No (ggplot2/sf) |
| fig_03_07_strategic_ports.R | Script only, no output | No (ggplot2/sf) |
| fig_03_08_russian_pipelines.R | Script only, no output | No (ggplot2/sf) |

### Current Approach
Scripts use `ggplot2` + `sf` + `rnaturalearth` with manual coordinate plotting.

## Proposed Changes

### Phase 1: Migrate to tmap Framework

Convert existing scripts to use `tmap` for:
- Cleaner syntax and better cartographic defaults
- Built-in scale bars, north arrows, and graticules
- Consistent styling across all maps
- Better legend handling
- Interactive mode option for HTML output

**New dependencies to add:**
```r
install.packages(c("tmap", "tmaptools", "leaflet"))
```

### Phase 2: Generate Missing Maps

#### Priority 1: Chapter 3 Maps (Critical Sectors)

1. **fig_03_04_chokepoints.png** - Maritime Energy Chokepoints
   - Strait of Hormuz, Malacca, Suez, Bab el-Mandeb, Panama, Turkish/Danish Straits
   - Show oil/LNG transit volumes
   - Add to Chapter 3 after line ~119 (maritime chokepoints section)

2. **fig_03_05_subsea_cables.png** - Global Telecommunications Infrastructure
   - Major landing points and cable routes
   - Highlight strategic vulnerabilities
   - Add to Chapter 5 (Information domain) or Chapter 3

3. **fig_03_07_strategic_ports.png** - Global Port Network
   - Top container ports by volume
   - Chinese-operated/invested ports highlighted
   - Belt and Road port investments
   - Add to Chapter 3 or Chapter 8 (Investment)

4. **fig_03_08_russian_pipelines.png** - Russian Energy Infrastructure
   - Nord Stream (damaged), TurkStream, Power of Siberia
   - Ukraine transit routes
   - Status color coding (operational/damaged/closed)
   - Add to Chapter 3 energy section or Chapter 9 (Historical cases - Russia)

#### Priority 2: New Maps to Create

5. **fig_02_01_semiconductor_geography.png** - Semiconductor Supply Chain Map
   - TSMC (Taiwan), Samsung (Korea), Intel (US/Ireland), ASML (Netherlands)
   - Fab locations and chokepoints
   - Add to Chapter 2 (Supply Chains)

6. **fig_07_02_swift_network.png** - Global Financial Infrastructure
   - SWIFT coverage and alternatives (CIPS, SPFS)
   - Sanctions exposure visualization
   - Add to Chapter 7 (Financial Statecraft)

7. **fig_08_01_bri_infrastructure.png** - Belt and Road Initiative
   - Key infrastructure projects
   - Ports, railways, pipelines
   - Add to Chapter 8 (Investment/Industrial Policy)

8. **fig_09_02_sanctions_map.png** - Global Sanctions Regimes
   - Countries under comprehensive/targeted sanctions
   - Historical comparison (Cold War vs. present)
   - Add to Chapter 9 (Historical Cases)

### Phase 3: Chapter Integration

Add figure references at appropriate locations in markdown:

```markdown
![Maritime Energy Chokepoints](figures/fig_03_04_chokepoints.png)
*Figure 3.4: Critical maritime passages for global energy transit. The Strait of Hormuz alone handles 21% of global oil consumption.*
```

## Technical Implementation

### tmap Script Template

```r
# Figure X.X: [Title]
library(here)
library(tidyverse)
library(sf)
library(tmap)
library(rnaturalearth)

source(here("R", "setup_theme.R"))

# Load base map
world <- ne_countries(scale = "medium", returnclass = "sf")

# Create data
points_sf <- st_as_sf(data, coords = c("lon", "lat"), crs = 4326)

# Build map
map <- tm_shape(world) +
  tm_polygons(fill = "#f0f0f0", col = "white") +
  tm_shape(points_sf) +
  tm_symbols(
    size = "volume",
    fill = "category",
    fill.scale = tm_scale_categorical(values = c("#d62728", "#ff7f0e", "#2ca02c")),
    size.scale = tm_scale_continuous(values.scale = 2)
  ) +
  tm_text("name", size = 0.7) +
  tm_scalebar(position = c("left", "bottom")) +
  tm_compass(position = c("right", "top")) +
  tm_title("[Figure Title]") +
  tm_layout(
    frame = FALSE,
    legend.position = c("left", "bottom"),
    legend.bg.color = "white"
  )

# Save
tmap_save(map, here("figures", "fig_XX_XX_name.png"),
          width = 12, height = 7, dpi = 300)
tmap_save(map, here("figures", "fig_XX_XX_name.pdf"),
          width = 12, height = 7)
```

### Styling Consistency

All maps should use:
- Same color palette as other figures (setup_theme.R colors)
- Consistent font sizing
- Scale bars in km
- Source citations in caption
- PDF + PNG output

## Execution Checklist

- [ ] Install tmap and dependencies
- [ ] Create tmap version of setup_theme.R helpers
- [ ] Convert fig_03_04_chokepoints.R to tmap
- [ ] Run and verify output
- [ ] Convert fig_03_05_subsea_cables.R to tmap
- [ ] Convert fig_03_07_strategic_ports.R to tmap
- [ ] Convert fig_03_08_russian_pipelines.R to tmap
- [ ] Create new fig_02_01_semiconductor_geography.R
- [ ] Create new fig_07_02_swift_network.R (or verify existing fig_07_01)
- [ ] Create new fig_08_01_bri_infrastructure.R
- [ ] Add figure references to chapters 2, 3, 5, 7, 8, 9
- [ ] Recompile PDF and verify figures render correctly
