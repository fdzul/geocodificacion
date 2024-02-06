
# Step 1. apply the vector addreses ####
addresses <- denhotspots::data_geocoden(infile = "dengue_mx_2024_02_01",
                                        data = FALSE,
                                        sinave_new = TRUE)

# Step 2. text manipulation ####
stringr::str_subset(addresses, "Campeche")

addresses <- stringr::str_replace_all(addresses,
                                      pattern = " , ",
                                      replacement = " ,")
addresses <- stringr::str_replace_all(addresses,
                                      pattern = "CALLE CALLEJON ",
                                      replacement = "CALLEJON ")
addresses <- stringr::str_replace_all(addresses,
                                      pattern = "CALLE DOM CON ,",
                                      replacement = "")
addresses <- stringr::str_replace_all(addresses,
                                      pattern = "CALLEJON CALLEJON ",
                                      replacement = "CALLEJON ")
addresses <- stringr::str_replace_all(addresses,
                                      pattern = "CENTRO  CENTRO,",
                                      replacement = " CENTRO,")
addresses <- stringr::str_replace_all(addresses,
                                      pattern = "QUINT ROO",
                                      replacement = " ")
addresses <- stringr::str_replace_all(addresses,
                                      pattern = " YUC",
                                      replacement = " ")
addresses <- stringr::str_replace_all(addresses,
                                      pattern = ",CENTRO IXHUATLÁN DEL SURESTE ,",
                                      replacement = ",CENTRO,")

addresses <- stringr::str_replace_all(addresses,
                                      pattern = "62744 CUAUTLA  MOR",
                                      replacement = "CUAUTLA")


addresses[1484] <- "COLONIA DEL PRI ,Ciudad OMETEPEC ,41700 OMETEPEC, Guerrero,Mexico"
# Step 3. geocoding ###
denhotspots::geocoden(infile = "dengue_mx_2024_02_01")



# Step 4. load the dengue geocoded & dengue dataset #####
if(as.vector(Sys.info()["sysname"]) == "Darwin"){
    z <- readRDS("~/Library/CloudStorage/OneDrive-Personal/proyects/geocoding_mex/2024/dengue_mx_2024_02_01_temp_geocoded.rds")
} else if(as.vector(Sys.info()["sysname"]) == "Windows"){
    z <- readRDS("D:/OneDrive/proyects/geocoding_mex/2023/dengue_mx_2024_01_23_temp_geocoded.rds")
} else if(as.vector(Sys.info()["sysname"]) == "Linux"){
    
}

# Step 5. load the dengue dataset ####
data <- denhotspots::data_geocoden(infile = "dengue_mx_2024_02_01", 
                                   data = TRUE,
                                   sinave_new = TRUE)
# Step 6. save the results #####
denhotspots::save_geocoden(x = z,
                           y = data,
                           directory = "9.geocoded_data",
                           loc = "dengue_mx_2024_02_01")





