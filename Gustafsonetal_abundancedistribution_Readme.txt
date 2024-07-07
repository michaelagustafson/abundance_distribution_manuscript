This readme file was generated on [2024-07-07] by [Michaela Gustafson]
<help text in angle brackets should be deleted before finalizing your document>
<[text in square brackets should be changed for your specific dataset]>


GENERAL INFORMATION

Title of Dataset: Ptarmigan and squirrel abundance and distribution

Author/Principal Investigator Information
Name: Michaela Gustafson	
ORCID:
Institution: 
Address: 
Email: michagustaf@gmail.com

Author/Associate or Co-investigator Information
Name: Jen Cruz
ORCID:
Institution: Boise State University
Address: 
Email: jencruz@boisestate.edu

Author/Alternate Contact Information
Name: Michael Henderson
ORCID:
Institution: The Peregrine Fund
Address: 
Email: Henderson.michael@peregrinefund.org

Date of data collection: May-July of 2019, 2021, and 2022 

Geographic location of data collection: Seward Peninsula, Alaska, United States of America


SHARING/ACCESS INFORMATION

Licenses/restrictions placed on the data: 

Links to publications that cite or use the data: 

Links to other publicly accessible locations of the data: 

Links/relationships to ancillary data sets: 


Recommended citation for this dataset: 


DATA & FILE OVERVIEW

File List: 

rock_timemodel.qmd: code containing model analysis and model fit for Rock Ptarmigan observations

squirrel_timemodel.qmd: code containing model analysis and model fit for Arctic ground squirrel observations

willow_timemodel.qmd: code containing model analysis and model fit for Willow Ptarmigan observations


data/percent cover standardized/XXXX.tif: this folder, "percent cover standardized" within the "data" folder contains the .tif files for the various land cover variables used in model analysis for each species

data/all_site_env.csv: Observation data collected at each point/site for all points in all years and land cover data extracted for each point

data/elev_std.tif: .tif file of the standardized elevation values used in model analysis

data/raw_hab_vals.csv: Unstandardized values of the percent of each land cover type (veg/habitat and elevation) for each point in all years. Used for partial prediction plots

data/rockmalesonly_timedist_9nov23.csv: all male Rock Ptarmigan observations used in analysis

data/si_obs_covs_scaled_16nov23.csv: contains observations for all male Willow Ptarmigan observations and all standardized site and observation covariates for all sites in all years. Since covariates are the same for all sites, these columns are imported into the Rock Ptarmigan and Squirrel model codes.

data/squironly_timedist_10nov23.csv: all Arctic ground squirrel observations used in analysis



METHODOLOGICAL INFORMATION

Description of methods used for collection/generation of data: <include links or references to publications or other documentation containing experimental design or protocols used in data collection>

Methods for processing the data: <describe how the submitted data were generated from the raw or collected data>

Instrument- or software-specific information needed to interpret the data: <include full name and version of software, and any necessary packages or libraries needed to run scripts>

Standards and calibration information, if appropriate: 

Environmental/experimental conditions: 

Describe any quality-assurance procedures performed on the data: 

People involved with sample collection, processing, analysis and/or submission: 


DATA-SPECIFIC INFORMATION FOR: [all_site_env.csv]

Number of variables: 10

Number of cases/rows: 916

Variable List: <list variable name(s), description(s), unit(s) and value labels as appropriate for each>

-id: unique site id

-julian: day of year - not 'true' julian date

-year: year site was observed

-min_after_sun: minutes after end of civil twilight that survey began - if negative, started before true sunrise (sun at 0 degrees on horizon)

-observer: unique ID of primary observer

-tempf: temperature at time of survey in Fahrenheit

-sky: code for condition of sky; 0 = clear/few clouds, 1-partly cloudy, 2= cloudy/overcast, 3=light fog, 4 = drizzle, 5 = showers

-wind: wind speed in miles per hour 

-hear: categorical depiction of how much your ability to hear clearly was affected by background noise, wind, etc; 0=not reduced, 1=barely reduced, 2=noticeable reduced, 3 = greatly reduced

DATA-SPECIFIC INFORMATION FOR: [rockmalesonly_timedist_9nov23.csv]

Number of variables: 3

Number of cases/rows: 55 *** each row is an observation of a single (one) male Rock Ptarmigan


Variable List: <list variable name(s), description(s), unit(s) and value labels as appropriate for each>

-id: unique site id that Rock Ptarmigan was observed at

-time_int: time interval (minute) that Rock Ptarmigan was observed during 

-exact_distance: distance from observer that Rock Ptarmigan was observed (distance measured using rangefinder)


DATA-SPECIFIC INFORMATION FOR: [squironly_timedist_10nov23.csv]

Number of variables: 3

Number of cases/rows: 80 *** each row is an observation of a single (one) squirrel

Variable List: 

-id: unique site id that squirrel was observed at

-time_int: time interval (minute) that squirrel was observed during 

-exact_distance: distance from observer that squirrel was observed (distance measured using rangefinder)



DATA-SPECIFIC INFORMATION FOR: [si_obs_covs_scaled_16nov23.csv]

Number of variables: 27

Number of cases/rows: 988 *** each row is a unique site

Variable List: 

-X.0.2., X.2.4., X.4.6., X.6.8., X.8.10.: time interval (minute) that Willow Ptarmigan was observed during. The number in that row x column is the number of Willow Ptarmigan observed at that site during that specific time interval *** Data was filtered to only include Willow Ptarmigan that were observed at or less than 400 m from the observer. Distances were measured using a rangefinder.

-id: unique site id that Willow Ptarmigan was/were observed at

-wind: standardized value of wind(mph) for that site during time of survey

-julian: day of year (not true julian date) for that site during time of survey

- min_after_sun: minutes after end of civil twilight or when the sun reaches 0 degrees on the horizon that the survey at that site took place. Negative indicates survey was conducted before 'sunrise'

-observer: unique ID for primary observer of the survey

- egforest, ...  water: standardized value of the percent of that land cover type within an 800m2 area of the survey point

- extracted_elev: standardized elevation for each point. unstandardized elevation value is the mean elevation for land within 800m2 of survey point

- area: value used for area offset in model to standardize prediction values
