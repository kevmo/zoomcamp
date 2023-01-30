
SELECT COUNT(*) 
FROM green_taxi gt 
WHERE gt.lpep_pickup_datetime 
BETWEEN 2019-01-15 00:00:00 AND 2019-01-15 23:59:59
AND gt.lpep_dropoff_datetime 
BETWEEN 2019-01-15 00:00:00 AND 2019-01-15 23:59:59;




-----

docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  --network=pg-network \
  --name pg-database \
  postgres

https://herewecode.io/blog/create-a-postgresql-database-using-docker-compose/


wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-01.csv.gz

wget https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv

pgcli -h localhost -p 5432 -u postgres -d ny_taxi
pgcli -h localhost -p 5432 -u root -d ny_taxi

docker pull dpage/pgadmin4

docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  --network=pg-network \
  --name pgadmin \
  dpage/pgadmin4    


