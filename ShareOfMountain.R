library(sf)
library(ggplot2)
library(dplyr)
library(rnaturalearth)
library(elevatr)
library(raster)

mountains <- st_read("C:/Users/Admin/Рабочий стол/Mountains/GMBA_Inventory_v2.0_standard_300.shp")

#https://www.earthenv.org/mountains


tianshan <- mountains %>%
  filter(MapName == "Tian Shan") %>%
  st_union() %>%
  st_as_sf() %>%
  st_transform(4326)

countries <- ne_countries(scale = "medium", returnclass = "sf") %>%
  filter(admin %in% c("Afghanistan", "China", "Kazakhstan", "Kyrgyzstan",
                      "Tajikistan", "Turkmenistan", "Uzbekistan")) %>%
  st_transform(4326)

tianshan_by_country <- st_intersection(countries, tianshan)

country_colors <- c(
  "Afghanistan"  = "#f4a582",
  "China"        = "#e06666",
  "Kazakhstan"   = "#ffd966",
  "Kyrgyzstan"   = "#93c47d",
  "Tajikistan"   = "#c27ba0",
  "Turkmenistan" = "#76a5af",
  "Uzbekistan"   = "#6fa8dc"
)


dem <- get_elev_raster(
  locations = tianshan,
  z = 7,
  clip = "bbox"
)
dem_tianshan <- mask(crop(dem, tianshan), tianshan)
dem_df <- as.data.frame(rasterToPoints(dem_tianshan))
colnames(dem_df) <- c("x", "y", "elevation")


ts_bbox <- st_bbox(tianshan)
expand_factor <- 0.2
x_range <- ts_bbox["xmax"] - ts_bbox["xmin"]
y_range <- ts_bbox["ymax"] - ts_bbox["ymin"]
xlim <- c(ts_bbox["xmin"] - expand_factor * x_range,
          ts_bbox["xmax"] + expand_factor * x_range)
ylim <- c(ts_bbox["ymin"] - expand_factor * y_range,
          ts_bbox["ymax"] + expand_factor * y_range)


ggplot() +
  geom_sf(data = countries, fill = NA, color = "black", size = 0.5) +
  geom_raster(data = dem_df, aes(x = x, y = y, fill = elevation)) +
  scale_fill_gradientn(colours = terrain.colors(10), name = "Elevation (m)") +
  geom_sf(data = tianshan_by_country, aes(geometry = geometry, fill_country = admin),
          color = "black", size = 0.4, alpha = 0.6, inherit.aes = FALSE) +
  scale_fill_manual(values = country_colors, guide = "none", aesthetics = "fill_country") +
  coord_sf(xlim = xlim, ylim = ylim, expand = FALSE) +
  theme_void() +
  theme(
    plot.background = element_rect(fill = "grey90", color = NA),
    legend.position = "none"
  )
