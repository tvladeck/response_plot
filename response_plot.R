library(ggmap)
US <- read.delim("US.txt", header=FALSE)

colnames(US) <- c("country", "zip", "city", "state_long", "state_ab", "region", "ign1", "ign2", "ign3", "lat", "lon", "ign4")

US <- select(US, -starts_with("ign"))

# assume you have a data frame _df_ w/ an existing column called zip

df <- left_join(as.data.frame(demo), US, by = "zip")


responses_point_plot <- 
  qmplot(lon, lat, data = df, 
         maptype = "toner-2011", 
         darken = .1, 
         geom = "blank") + 
    geom_point(color = cm.colors(2)[2], alpha = 0.75)

responses_gradient_plot <- 
  qmplot(lon, lat, data = a, 
         geom = "blank", 
         zoom = 9, 
         maptype = "toner-2011", 
         darken = .1) +
    stat_density_2d(aes(fill = ..level..), 
                    geom = "polygon", alpha = .5, color = NA) +
    scale_fill_gradient2( 
                         low = cm.colors(5)[1], 
                         mid = cm.colors(5)[3], 
                         high = cm.colors(5)[5],
                         midpoint = 5, 
                         guide = F) + 
    theme_void()
