# Initialize Data Hub

    gradlew hubInit

# Create Entities

    gradle -PentityName=airport hubCreateEntity 

# Create Input Flows
 
    gradle hubCreateInputFlow -PentityName=airport -PflowName=newMexicoInput -PdataFormat=xml -PpluginFormat=xqy
    gradle hubCreateInputFlow -PentityName=airport -PflowName=northDakotaInput -PdataFormat=xml -PpluginFormat=xqy
    
# Create Harmonize Flows

    gradle hubCreateHarmonizeFlow -PentityName=airport -PflowName=harmonizeNewMexicoAirport -PdataFormat=xml -PpluginFormat=xqy
    gradle hubCreateHarmonizeFlow -PentityName=airpot -PflowName=harmonizeNorthDakotaAiport

# Run Harmonize Flow

    gradle hubRunFlow -PentityName=airport -PflowType=harmonize -PflowName=harmonizeNewMexicoAirport