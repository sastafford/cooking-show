# MarkLogic Cooking Show

Show customers a quick demonstration of a Data Hub project.  

## Script 

You will run two ingest flows and then two harmonize flows to ingest airport data from New Mexico and North Dakota.

Open up the Quick Start Data Hub user interface.  Explain the data you are ingesting and then run the input flows. 

Show the data via QConsole.  Highlight the need for a canonical model to represent elevation.  This will make
queries much more simple.  

Run the harmonize flows for the two data sets.

Highlight the header information that exists now for elevation. 

Run the following queries from POSTMAN.  You will need to change the environment variables of the collection for your 
environment.   

 + View Moriarty Municpal Airport
 + Airports within 100 miles of Las Cruces, NM 
 + Airports within 100 miles of Las Cruces, NM with a Hangar
 + Airport elevations between 3000 ft and 4000 ft
  
## Install

Install the demo.  The install scripts will take a few minutes to complete.  Default password is admin/admin

    docker-compose up -d
    
Load the POSTMAN Export.  Update the environment variables for the POSTMAN collection to your local environment.    

    ./postman/MarkLogic Cooking Show.postman_collection.json
    
Open the Data Hub Quickstart
  
     http://HOST:8080
     
Click NEXT twice and enter in default credentials. 

Show the Airport Entity

Run the two input flows

Run the two hamronization flows

Go into POSTMAN and run the three queries.  
