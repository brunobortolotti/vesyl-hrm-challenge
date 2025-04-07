# README

## Setup

This project is dockerized, so the easiest way to get started is to install docker on your local machine and run the following commands

### Pull the images and build the app
```
docker compose build app
```

### Prepare the database
```
docker compose run --rm app rails db:create db:migrate
```

### Create the `.env` file using `.env-sample` 
```
cp .env-sample .env
```

### Download external data file
```
docker compose run --rm app rails db:download_file
```

### Ingest the Users
```
docker compose run --rm app rails db:ingest_users
```

### Ingest the HRM Sessions
```
docker compose run --rm app rails db:ingest_sessions
```

### Ingest the HRM Sessions. 
```
docker compose run --rm app rails db:ingest_data_points
```
This part takes almost 1 hour to complete using 10 threads. You can speed up the process by increasing the number of threads, but be aware of the available resources of your machine.
You stop can the process in the middle of the execution to use a small subset of the data. The records will remain on the database.

### Start the server 
```
docker compose up app
```
Once the server is up, go to http://0.0.0.0:3001
