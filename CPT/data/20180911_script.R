#################################################################
#################################################################
###                                                           ###
###                                                           ###
###               Cascade Tuholske                            ###
###               Sep 11, 2018                                ###
###               Landsat Data for Bren 203                   ###
###                                                           ###
#################################################################
#################################################################

setwd("/Users/cascade/Box/WavesLab/LAProject/Data/LandSat/LC08_L1TP_041036_20180831_20180831_01_RT")

library(sp)
library(raster)
library(maptools)
library(rgdal)

band4 <- raster("LC08_L1TP_041036_20180831_20180831_01_RT_B4.TIF") #Red
band5 <- raster("LC08_L1TP_041036_20180831_20180831_01_RT_B5.TIF") #NIR


# Band Math ---------------------------------------------------------------

# NDVI = (NIR — VIS)/(NIR + VIS)

ndvi = (band5 - band4)/(band5 + band4)
band4 <- raster("LC08_L1TP_041036_20180831_20180831_01_RT_B4.TIF") #Red
band5 <- raster("LC08_L1TP_041036_20180831_20180831_01_RT_B5.TIF") #NIR

# CALCULATE LST 

#Values from Metafile
RADIANCE_MULT_BAND_10 <- 3.3420E-04
RADIANCE_MULT_BAND_11 <- 3.3420E-04

RADIANCE_ADD_BAND_10 <- 0.10000
RADIANCE_ADD_BAND_11 <- 0.10000

band_10 <- raster("LC08_L1TP_041036_20180831_20180831_01_RT_B10.TIF") #change image name accordingly
band_11 <- raster("LC08_L1TP_041036_20180831_20180831_01_RT_B11.TIF") #change image name accordingly

#Calculate TOA from DN:
toa_band10 <- calc(band_10, fun=function(x){RADIANCE_MULT_BAND_10 * x + RADIANCE_ADD_BAND_10})
toa_band11 <- calc(band_11, fun=function(x){RADIANCE_MULT_BAND_11 * x + RADIANCE_ADD_BAND_11})

#Values from Metafile
K1_CONSTANT_BAND_10 = 774.8853
K2_CONSTANT_BAND_10 = 1321.0789
K1_CONSTANT_BAND_11 = 480.8883
K2_CONSTANT_BAND_11 = 1201.1442

#Calculate LST in Kelvin for Band 10 and Band 11
temp10_kelvin <- calc(toa_band10, fun=function(x){K2_CONSTANT_BAND_10/log(K1_CONSTANT_BAND_10/x + 1)})
temp11_kelvin <- calc(toa_band11, fun=function(x){K2_CONSTANT_BAND_11/log(K1_CONSTANT_BAND_11/x + 1)})

#Convert Kelvin to Celsius for Band 10 and 11
temp10_celsius <- calc(temp10_kelvin, fun=function(x){x - 273.15})
temp11_celsius <- calc(temp11_kelvin, fun=function(x){x - 273.15})

#Export raster images
writeRaster(temp10_celsius, "temp10_c.tif")
writeRaster(temp11_celsius, "temp11_c.tif")
writeRaster(ndvi, "ndvi.tif")

# data clean ----------------------------------------------------

rs.data <- data.frame(read.csv("/Users/cascade/Box/WavesLab/LAProject/Data/QGiS/LaCountires_NDVI_LST.csv"))
medinc <- data.frame(read.csv("/Users/cascade/Box/WavesLab/LAProject/Data/QGiS/La_medInc.csv"))
crime <- data.frame(read.csv("/Users/cascade/Box/WavesLab/LAProject/Data/QGiS/La_crime.csv"))
white <- data.frame(read.csv("/Users/cascade/Box/WavesLab/LAProject/Data/QGiS/La_white.csv"))
black <- data.frame(read.csv("/Users/cascade/Box/WavesLab/LAProject/Data/QGiS/La_black.csv"))
home <- data.frame(read.csv("/Users/cascade/Box/WavesLab/LAProject/Data/QGiS/La_home.csv"))
latino <- data.frame(read.csv("/Users/cascade/Box/WavesLab/LAProject/Data/QGiS/La_latino.csv"))
diversity <- data.frame(read.csv("/Users/cascade/Box/WavesLab/LAProject/Data/QGiS/La_diversity.csv"))
parent <- data.frame(read.csv("/Users/cascade/Box/WavesLab/LAProject/Data/QGiS/La_parent.csv"))
popden <- data.frame(read.csv("/Users/cascade/Box/WavesLab/LAProject/Data/QGiS/La_popdensity.csv"))

merge <- base::merge(rs.data, medinc, by.x = "name", by.y = "name", all.x = TRUE)
merge <- base::merge(merge, crime, by.x = "name", by.y = "name", all.x = TRUE)
merge <- base::merge(merge, white, by.x = "name", by.y = "name", all.x = TRUE)
merge <- base::merge(merge, black, by.x = "name", by.y = "name", all.x = TRUE)
merge <- base::merge(merge, home, by.x = "name", by.y = "name", all.x = TRUE)
merge <- base::merge(merge, latino, by.x = "name", by.y = "name", all.x = TRUE)
merge <- base::merge(merge, diversity, by.x = "name", by.y = "name", all.x = TRUE)
merge <- base::merge(merge, parent, by.x = "name", by.y = "name", all.x = TRUE)
merge <- base::merge(merge, popden, by.x = "name", by.y = "name", all.x = TRUE)

final.data <- data.frame(merge$name, 
                         merge$ndvimean, 
                         merge$tempmean,
                         merge$med_inc,
                         merge$crime_percapita,
                         merge$crime_total,
                         merge$diversity_index,
                         merge$pct_black,
                         merge$pct_white,
                         merge$pct_latino,
                         merge$pct_home,
                         merge$pct_single_parent,
                         merge$pop_density)

colnames(final.data) <- c("neigborhood", "ndvi_mean", "temp_mean", "median_inc", "crime_percapita",
                          "crime_total", "diversity_index", "pct_black", "pct_white", "pct_latino",
                          "pct_homeowner", "pct_single_parent", "pop_density")

write.csv(final.data, file = "Bren203_F18_LA_Data.csv")










