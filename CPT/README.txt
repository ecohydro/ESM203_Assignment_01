Files for ESM 203 Ass. 1
Prepared by Cascade Tuholske Sep 2020, updated from 2018

--- Dir Structure 
- data/la-county-regions-v6 are the shape files from http://maps.latimes.com/neighborhoods/
- data/ESM203_F2020_Ass1.csv (and .shp) is the data produced for the 2020 assignment 
- cpt_Makedata.jpyter .ipynb is used by CPT to make all the data for data/ESM203_F2020_Ass1.csv
- data/socioeconomic is the LA times socioeconomic data manually made
- data/landsat is the landsat data (not pushed to repo) pulled from USGS Earth Explorer 

--- Notes
- data/Bren203_F18_LA_Data.csv is the 2018 Data
- Socioeconomic data is pulled manually into .csv files from : http://maps.latimes.com/neighborhoods/ and then selecting a 'ranking'
- Socioeconomic data has been merged into Bren203_F18_LA_Data.csv, which will be updated for Fall 2020
- 20180911_script.R will make NDVI and Last Surface Temp from 2018 Landsat scenes, but will not do zonal stats
- 20180911_script.R will merge area-averaged neigbhorhoods and old socioeconomic .csv files by neigbhorhoods label
