# Share of the Tian Shan Mountains

## Description
This script visualizes the distribution of the **Tian Shan** mountain system across countries, with elevation overlay and country-based color differentiation.

The Tian Shan is one of the largest mountain ranges in Asia, spanning **7 countries**:
- 🇨🇳 **China**
- 🇰🇬 **Kyrgyzstan**
- 🇰🇿 **Kazakhstan**
- 🇹🇯 **Tajikistan**
- 🇺🇿 **Uzbekistan**
- 🇦🇫 **Afghanistan**
- 🇹🇲 **Turkmenistan**

---

## How to Use

1. Download the **GMBA Mountain Inventory v2.0** dataset from:  
   [https://www.earthenv.org/mountains](https://www.earthenv.org/mountains)  

2. Extract the archive to a convenient location on your computer.  
   Example:  
C:/Users/Admin/Desktop/Mountains/

Inside this directory, you should have:
GMBA_Inventory_v2.0_standard_300.shp


3. Make sure you have the required R packages installed:
install.packages(c("sf", "ggplot2", "dplyr", "rnaturalearth", "elevatr", "raster"))
Open the script tian_shan_map.R and update the file path to your local directory:


mountains <- st_read("C:/Users/Admin/Desktop/Mountains/GMBA_Inventory_v2.0_standard_300.shp")
Run the script — it will produce a map showing the distribution of the Tian Shan across countries.

Customizing Colors
Country colors are defined in the following block:

r
Копировать
Редактировать
country_colors <- c(
  "Afghanistan"  = "#f4a582",
  "China"        = "#e06666",
  "Kazakhstan"   = "#ffd966",
  "Kyrgyzstan"   = "#93c47d",
  "Tajikistan"   = "#c27ba0",
  "Turkmenistan" = "#76a5af",
  "Uzbekistan"   = "#6fa8dc"
)
You can replace these HEX codes with any colors you prefer.

Example Output

Data Sources:

GMBA Mountain Inventory v2.0 — https://www.earthenv.org/mountains

Natural Earth — https://www.naturalearthdata.com

SRTM Elevation Data — https://www2.jpl.nasa.gov/srtm/
