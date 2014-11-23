# Load Data frame
#-----------------
df <- read.px('data_bfs/px-d-01-2A01.px', encoding = 'latin1')
df <- as.data.frame(df, stringsAsFactors = F, encoding = 'latin1')
agv <- read.csv2(file = 'data_bfs/praemienregionen.csv', header = T, sep = ';', stringsAsFactors = F, encoding = 'latin1')

# Variables to upper case
names(df) <- tolower(names(df))
names(agv) <- tolower(names(agv))

names(df) <- gsub(pattern = '[.]', replacement = '', x = names(df))

# Rename variables
names(df)[names(df) == 'kantonbezirkgemeinde'] <- 'gdename'
names(df)[names(df) == 'dat'] <- 'anzahl'
names(df)[names(df) == 'staatsangehörigkeit'] <- 'nation'

names(agv)[names(agv) == 'ortsbezeichnung'] <- 'gdename'
names(agv)[names(agv) == 'bfs.nr'] <- 'gdenr'

# Rename Gemeinde
df$gdename <- as.character(df$gdename)
df$gdename <- substr(x = df$gdename, start = 7, stop = nchar(df$gdename))
df$gdenr <- substr(x = df$gdename, start = 1, stop = 4)
df$gdename <- substr(x = df$gdename, start = 6, stop = nchar(df$gdename))

# Reformat
df$gdenr <- as.numeric(df$gdenr)

# Reduce to only children and grownups
#-------------------------------------
total <- filter(df, alter == 'Total')
children <- summarise(group_by(x = filter(df, alter != 'Total'), gdenr, nation), sum(anzahl))
names(children)[names(children) == 'sum(anzahl)'] <- 'anzahl'

children <- cbind(total[, !names(total) %in% names(children)], children)
children <- children[, names(total)]

grownups <- total
children <- children[order(children$gdenr,children$nation, children$bevölkerungstyp), ]
total <- total[order(total$gdenr,total$nation, total$bevölkerungstyp), ]
grownups <- grownups[order(grownups$gdenr,grownups$nation, grownups$bevölkerungstyp), ]

grownups$anzahl <- grownups$anzahl - children$anzahl

# Rename categories
children$alter <- 'kinder'
grownups$alter <- 'erwachsene'

df <- rbind(children, grownups)

rm(children, grownups, total)

# Cast (flaten) the df
#---------------------
df <- dcast(df, gdenr ~ nation + alter, value.var = 'anzahl')

df <- mutate(df, aus_kind_perc = round((Ausländer_kinder / Total_kinder) * 100, 0))
df <- mutate(df, aus_erw_perc = round((Ausländer_erwachsene / Total_erwachsene) * 100, 0))

# Merge with plz
df <- merge(df, agv[, c('gdenr', 'gdename', 'plz')], intersect = 'gdenr', all.x = T, all.y = F)
df <- df[!is.na(df$aus_kind_perc), ]
df <- df[!is.na(df$plz), ]
df <- df[!duplicated(df$plz), ]

rm(agv)
