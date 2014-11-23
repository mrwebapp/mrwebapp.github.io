# Setup
#------
library(maptools); library(RColorBrewer); library(classInt); library(devEMF)

# Load Shapefile
shape <- readShapePoly('data_geo/PLZ.shp')

shape$NAME <- as.character(shape$NAME)
Encoding(shape$NAME) <- 'latin1'

# Fact to numeric
shape$ID <- as.numeric(levels(shape$ID[shape$ID]))

# Sort the shape file --> Umlaute!!!
shape <- merge(shape, df, by.x = 'ID', by.y = 'plz', all = T, sort = T)
shape$aus_erw_perc <- ifelse(is.na(shape$aus_erw_perc), 0, shape$aus_erw_perc)

# Plot Shapefile
#----------------
# Colors
colors <- shape$aus_erw_perc
col <- brewer.pal(9, "Reds")
col <- col[(length(col) - 6):(length(col))]

brks_pos <- classIntervals(as.numeric(shape$aus_erw_perc[as.numeric(shape$aus_erw_perc) > 0]), n = 6, style = "quantile")$brks
colors[as.numeric(shape$aus_erw_perc) > 0] <- col[findInterval(shape$aus_erw_perc[as.numeric(shape$aus_erw_perc) > 0], brks_pos, all.inside = T)]
colors[as.numeric(shape$aus_erw_perc) == 0] <- 'black'

# Plot the map
png('plots/aus_erw.png', bg = 'transparent', width = 1800, height = 1080)
plot(shape, col = colors)
dev.off()

#------------
# Plot Shapefile
#----------------
# Colors
colors <- shape$aus_kind_perc
col <- brewer.pal(9, "Reds")
col <- col[(length(col) - 6):(length(col))]

shape$aus_kind_perc[is.na(shape$aus_kind_perc)] <- 0
brks_pos <- classIntervals(as.numeric(shape$aus_kind_perc[as.numeric(shape$aus_kind_perc) > 0]), n = 6, style = "quantile")$brks
colors[as.numeric(shape$aus_kind_perc) > 0] <- col[findInterval(shape$aus_kind_perc[as.numeric(shape$aus_kind_perc) > 0], brks_pos, all.inside = T)]
colors[as.numeric(shape$aus_kind_perc) == 0] <- 'purple'

# Plot the map
png('plots/aus_kind.png', bg = 'transparent', width = 1800, height = 1080)
plot(shape, col = colors)
dev.off()
hist(shape$aus_erw_perc, xlim = c(0, 100))
shape$NAME[shape$aus_erw_perc > 60]

x <- apply(df, 2, as.character)
x <- apply(x, 2, function(x){gsub(' ', '', x)})
x <- as.data.frame(x, encoding = 'latin1')
write.table(x, file = 'data_bfs/bfs_data_output.csv', row.names = F, sep = ';', qmethod = "double")
m <- read.csv2('data_bfs/bfs_data_output.csv', encoding = 'utf-8')
write.table(x, file = 'data_bfs/bfs_data_output.csv', row.names = F, sep = ';',
            qmethod = "double", fileEncoding = 'latin1')

?write.table

?write.table

x <- read.table('data_bfs/bfs_data_output.csv', sep = ';', header = T, stringsAsFactors = F)

iconv(x$gdename, 'l')
