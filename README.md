# Initialize Data Hub

    gradlew hubInit

# Create Entities

    gradle -PentityName=airport hubCreateEntity 

# Create Input Flows
 
    gradle hubCreateInputFlow -PentityName=airport -PflowName=newMexicoInput -PdataFormat=xml -PpluginFormat=xqy
    gradle hubCreateInputFlow -PentityName=airport -PflowName=northDakotaInput -PdataFormat=xml -PpluginFormat=xqy
    
# Create Harmonize Flows

    gradle hubCreateHarmonizeFlow -PentityName=airport -PflowName=NewMexicoAirport -PdataFormat=xml -PpluginFormat=xqy
    gradle hubCreateHarmonizeFlow -PentityName=airpot -PflowName=NorthDakotaAiport -PdataFormat=xml -PpluginFormat=xqy

# Run Harmonize Flow

    gradle hubRunFlow -PentityName=airport -PflowType=harmonize -PflowName=harmonizeNewMexicoAirport