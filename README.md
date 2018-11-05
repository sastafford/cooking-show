# MarkLogic Cooking Show

The MarkLogic Cooking Show is a tutorial designed to help learn developers learn MarkLogic.  The tutorial starts by ingesting several data sets from the [New York City Open Data Project](https://data.cityofnewyork.us/) via Apache NiFi.  Once data is ingested, several queries will be executed in MarkLogic's Query Console.  Setup for MarkLogic and Apache NiFi are facilitated using Docker.  

## Prerequisites

 * Docker version 18.06.1-ce
 * docker-compose version 1.22.0
 * [Docker Hub account](https://hub.docker.com/)

## How do I set up? 

1) Clone this repository

2) Create a MarkLogic Docker Image. See [README](./docker/README.md) under the Docker directory

3) Under the project root directory, change the image for the "marklogic" service to the docker image created in Step #2. 

4) Start the set of containers using docker-compose.  Make sure to wait about a minute for all these containers to initialize.  

<!-- comment -->

    docker-compose up -d

If the docker containers fail to initialize, make sure to allocate more memory and CPU's to the docker daemon.  

5) Copy the following data sets into the data directory.

 * [New York City Borough Boundaries](https://data.cityofnewyork.us/api/geospatial/tqmj-j8zm?method=export&format=GeoJSON)
 * [New York City Community Districts](https://data.cityofnewyork.us/api/geospatial/yfnk-k7r4?method=export&format=GeoJSON)
 * [New York City Neighborhood Names](https://data.cityofnewyork.us/api/geospatial/99bc-9p23?method=export&format=GeoJSON)
 * [New York City Places of Interest](https://data.cityofnewyork.us/api/geospatial/rxuy-2muj?method=export&format=GeoJSON)

 ## What docker containers are running? 

### MarkLogic

 * MarkLogic Admin Console: http://localhost:8001
 * Query Console: http://localhost:8000/qconsole
 
### Apache NiFi

Apache NiFi is used to batch ingest data into MarkLogic.

 * Apache NiFi: http://localhost:8080/nifi

### Gradle

Gradle is a build tool that is used to initialize MarkLogic.  There are three steps of initialization that are executed.  The first step is to initialize MarkLogic including installing the security database and the admin user.  The final step is to install a database called cooking-show-content and an app server called cooking-show.  

## Ingest NYC Data

1) The Points of Interest data file is not valid JSON due to an extra carriage return on line 278826.  Recommend running this JSON file through a JSON Lint program.  
2) Open up [Apache NiFi](http://localhost:8080/nifi). 
3) [Import the template](https://nifi.apache.org/docs/nifi-docs/html/user-guide.html#Import_Template) 

<!-- comment -->

    ./nifi/templates/Ingest_GeoJSON.xml

4) [Instantiate the template](https://nifi.apache.org/docs/nifi-docs/html/user-guide.html#instantiating-a-template) that was imported on the previous step.  

5) Open up the configuration of the PutMarkLogic processor.  Open the configuration for the connection, add the password - admin.  Enable the connection.

6) Select all the processors and start up the data flow.  

7) Copy the four geojson data files from ./data to ./nifi/staging

## Query the Data

1) Open up [Query Console](http://localhost:8000/qconsole).
2) Select the cooking-show-content database
3) Select the "Explore" button.  There should be 20196 documents in the database.
4) [Import the workspace](http://docs.marklogic.com/guide/qconsole/walkthru#id_22814) found under ./MarkLogic/Workspace.xml
5) Review each of the queries.  

## How do I uninstall?  

To remove these docker images execute the following command.

    docker-compose down

The MarkLogic forest information is stored in a docker volume and will persist beyond the lifetime of your MarkLogic docker container. 
