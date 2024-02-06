
# Step 1. load dengue dataset the current week ####
y <- denhotspots::read_dengue_dataset(path = "1.data/semana_actual/DENGUE2_.txt",
                                      spatial_resolution = "state",
                                      des_edo_res = "GUERRERO",
                                      status_caso = c(1, 2)) 
table(y$ANO)
table(y$DES_MPO_RES)
table(y$SEM)

# Step 2. load dengue dataset the last week ####
x <- denhotspots::read_dengue_dataset(path = "1.data/semana_pasada/DENGUE2_.txt",
                                      spatial_resolution = "state",
                                      des_edo_res = "GUERRERO",
                                      status_caso = c(1, 2))


# Step 3. extract the ids not geocoded ###
z <- y |>
    dplyr::filter(!FOL_ID %in% unique(x$FOL_ID)) |>
    dplyr::arrange(FOL_ID)


# Step 4. save the results ####
write.csv(z, 
          file = "dengue_edo12_2024_02_01.csv")




