
# Step 1. load dengue dataset the current week ####
y <- denhotspots::read_dengue_dataset(path = "1.data/semana_actual/DENGUE2_.txt",
                                      spatial_resolution = "country",
                                      status_caso = c(2)) 
table(y$ANO)
table(y$DES_EDO_RES)
table(y$SEM)

# Step 2. load dengue dataset the last week ####
x <- denhotspots::read_dengue_dataset(path = "1.data/last_week/DENGUE2_.txt",
                                      spatial_resolution = "country",
                                      status_caso = c(1, 2))


length(unique(y$VEC_ID))
length(unique(x$VEC_ID))

length(unique(y$FOL_ID))- length(unique(x$FOL_ID))

nrow(y) -nrow(x)


# Step 3. extract the ids not geocoded ###
z <- y |>
    dplyr::filter(!FOL_ID %in% unique(x$FOL_ID)) |>
    dplyr::arrange(FOL_ID)


# Step 4. save the results ####
write.csv(z, 
          file = "dengue_mx_2024_02_01.csv")




