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

## What docker containers are running? 

### MarkLogic

 * MarkLogic Admin Console: http://localhost:8001
 * Query Console: http://localhost:8000/qconsole
 
### Apache NiFi

 * Apache NiFi: http://localhost:8080

### Gradle

Gradle is a build tool that is used to initialize MarkLogic.  There are three steps of initialization that are executed.  The first step is to initialize MarkLogic including installing the security database and the admin user.  The final step is to install a database called cooking-show-content and an app server called cooking-show.  

## Ingest NYC Data

## How do I uninstall?  

To remove these docker images execute the following command.

    docker-compose down

The MarkLogic forest information is stored in a docker volume and will persist beyond the lifetime of your MarkLogic docker container. 
