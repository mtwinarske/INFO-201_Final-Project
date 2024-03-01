library(ggplot2)
library(plotly)
library(tidyverse)


map_df <- read.csv("ShapeDataKingCounty.csv")
map_df$GEOID <- paste0("1400000US", map_df$GEOID)

map_KC <- ggplot(data = map_df) +
  geom_polygon(mapping = aes(x = LON,
                             Y = LAT,
                             Group = GEOID
                               )) + 
  # adding in Transit Center Locations
  geom_point(aes(x = LON,
                 y = LAT,
                 
                    ))
plot(map_KC)
