#   Script Name: Geocodificacion.R
#   Description: Imágenes necesarias para la presentación.
#   Created By:  Paco Goerlich.
#   Date:        24/03/2021
#   Last change: 24/04/2021

tictoc::tic("Total time")
library(tidyverse)
library(sf)
library(ggspatial)

#######################
#   MAPAS ESTATICOS   #
#######################
#   (1) Georeferenciado versus No georeferenciado
spain <- rnaturalearth::ne_states(country = "spain", returnclass = "sf") %>%
  filter(region != "Canary Is.")
plot(st_geometry(spain))

#       Necesitamos los bordes
coast   <- rnaturalearth::ne_coastline(scale = "large", returnclass = "sf")
country <- rnaturalearth::ne_countries(scale = "large", returnclass = "sf")

#   No georeferenciado
(NoGeo <- ggplot() +
  geom_sf(data = country, col = NA) +
  geom_sf(data = spain, aes(fill = region), show.legend = FALSE) +
  geom_sf(data = coast, color = "#969669", size = 0.4) +
  coord_sf(xlim = c(-9.4, 4.4), ylim = c(35.2, 43.8)) +
  theme_bw() +
  theme(panel.border = element_blank(),
        panel.background = element_rect(fill = "aliceblue"),
        panel.grid.major = element_blank(),
        axis.ticks = element_line(color = "white"),
        axis.text = element_text(size = 7, color = "white")))

ggsave("./img/02_NoGeo.jpg", width = 10, height = 8)


(SiGeo <- ggplot() +
  geom_sf(data = country, col = NA) +
  geom_sf(data = spain, aes(fill = region), show.legend = FALSE) +
  geom_sf(data = coast, color = "#969669", size = 0.4) +
  coord_sf(xlim = c(-9.4, 4.4), ylim = c(35.2, 43.8)) +
  annotation_scale(location = "br", width_hint = 0.2, pad_x = unit(0.2, "cm"), height = unit(0.2, "cm"),) +
  annotation_north_arrow(location = "br", which_north = "true",
                         pad_x = unit(0.8, "cm"), pad_y = unit(0.8, "cm"),
                         style = north_arrow_fancy_orienteering) +
  theme_bw() +
  theme(panel.border = element_blank(),
        panel.background = element_rect(fill = "aliceblue"),
        panel.grid.major = element_line(colour = "gray40", linetype = "dashed", size = 0.3),
        axis.text = element_text(size = 7, color = "red")))

ggsave("./img/02_SiGeo.jpg", width = 10, height = 8)


#   Tiempo de ejecución
tictoc::toc()

