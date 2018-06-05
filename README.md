# MarkLogic Cooking Show

Show customers a quick demonstration of a Data Hub project.

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

# Create Entities

    gradle -PentityName=airport hubCreateEntity 
    
# Create Harmonize Flows

    gradle hubCreateHarmonizeFlow -PentityName=airport -PflowName=NewMexicoAirport -PdataFormat=xml -PpluginFormat=xqy
    gradle hubCreateHarmonizeFlow -PentityName=airpot -PflowName=NorthDakotaAiport -PdataFormat=xml -PpluginFormat=xqy

# Run Harmonize Flow

    gradle hubRunFlow -PentityName=airport -PflowType=harmonize -PflowName=NewMexicoAirport

    gradle hubRunFlow -PentityName=airport -PflowType=harmonize -PflowName=NorthDakotaAirport

