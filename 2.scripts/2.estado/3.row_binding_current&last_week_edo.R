
# Step 1.1 load geocoded dengue dataset current week ###
if(as.vector(Sys.info()["sysname"]) == "Darwin"){
    load("~/Library/CloudStorage/OneDrive-Personal/proyects/geocoding_mex/2024/9.geocoded_data/geo_dengue_mx_2024_02_01.RData")
} else if(as.vector(Sys.info()["sysname"]) == "Windows"){
    load("D:/OneDrive/proyects/geocoding_mex/2023/9.geocoded_data/geo_dengue_mx_2023_12_14.RData")
} else if(as.vector(Sys.info()["sysname"]) == "Linux"){
    
}

y <- y[stringr::str_which(y$formatted_address,  " Mexico"),]


# Step 1.2 load geocoded dengue dataset last week ###
if(as.vector(Sys.info()["sysname"]) == "Darwin"){
    #load("~/Library/CloudStorage/OneDrive-Personal/proyects/geocoding_mex/2024/9.geocoded_dataset/dengue_mx_2024.RData")
    load("~/Library/CloudStorage/OneDrive-Personal/proyects/geocoding_mex/2024/8.RData/denmex_2024.RData")
} else if(as.vector(Sys.info()["sysname"]) == "Windows"){
    load("D:/OneDrive/proyects/geocoding_mex/2023/9.geocoded_dataset/dengue_mx_2023.RData")
} else if(as.vector(Sys.info()["sysname"]) == "Linux"){
    
}


# step 2.1 row binding ####
z <- rbind(z, y)

w <- denhotspots::read_dengue_dataset(path = "1.data/current_week/DENGUE2_.txt",
                                      spatial_resolution = "country",
                                      status_caso = c(1, 2))

z <- z |>
    dplyr::filter(VEC_ID %in% unique(w$VEC_ID)) |>
    dplyr::arrange(VEC_ID)

table(z$ANO)

# Step 3. save the results ####
save(z, file = "8.RData/denmex_2024.RData")
 