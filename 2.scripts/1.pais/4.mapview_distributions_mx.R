
# Step 1. load the dengue cases geocoded ####
if(as.vector(Sys.info()["sysname"]) == "Darwin"){
    load("~/Library/CloudStorage/OneDrive-Personal/proyects/geocoding_mex/2024/8.RData/denmex_2024.RData")
} else if(as.vector(Sys.info()["sysname"]) == "Windows"){
    load("D:/OneDrive/proyects/geocoding_mex/2023/9.geocoded_dataset/dengue_mx_2023.RData")
} else if(as.vector(Sys.info()["sysname"]) == "Linux"){
    
}


# Step 2. 
z <- z |>
    sf::st_as_sf(coords = c("long", "lat"),
                 crs = 4326) |>
    dplyr::mutate(ESTATUS_CASO = ifelse(ESTATUS_CASO == 1,
                                        "Probable",
                                        "Confirmado"))

confirmados <- z |>
    dplyr::filter(ESTATUS_CASO == "Confirmado")
probables <- z |>
    dplyr::filter(ESTATUS_CASO == "Probable")

serotype_1 <- z |>
    dplyr::filter(ESTATUS_CASO == "Confirmado") |>
    dplyr::filter(DENGUE_SER_TRIPLEX == 1)
serotype_2 <- z |>
    dplyr::filter(ESTATUS_CASO == "Confirmado") |>
    dplyr::filter(DENGUE_SER_TRIPLEX == 2)
serotype_3 <- z |>
    dplyr::filter(ESTATUS_CASO == "Confirmado") |>
    dplyr::filter(DENGUE_SER_TRIPLEX == 3)
serotype_4 <- z |>
    dplyr::filter(ESTATUS_CASO == "Confirmado") |>
    dplyr::filter(DENGUE_SER_TRIPLEX == 4)

##############
map <- mapview::mapview(probables,
                 col.regions = "#898F9C",
                 color = "white",
                 layer.name = "Probables") +
    mapview::mapview(confirmados,
                     col.regions = "#4267B2",
                     color = "white",
                     layer.name = "Positivos") +
    mapview::mapview(serotype_1,
                     col.regions = "#36C5F0",
                     color = "white",
                     layer.name = "DENV-1") +
    mapview::mapview(serotype_2,
                     col.regions = "#2EB67D",
                     color = "white",
                     layer.name = "DENV-2") +
    mapview::mapview(serotype_3,
                     col.regions = "#E01E5A",
                     color = "white",
                     layer.name = "DENV-3") +
    mapview::mapview(serotype_4,
                     col.regions = "#FC642D",#"#ECB22E",
                     color = "white",
                     layer.name = "DENV-4")


mapview::mapshot(x = map,
                 url = "dengue_map_2024_01_01.html")
