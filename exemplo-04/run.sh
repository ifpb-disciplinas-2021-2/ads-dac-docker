docker image build -t ricardojob/bd ./postgres
docker container run -p 5433:5432 --name bd -d ricardojob/bd 

cd app && mvn clean package && cd ..
docker image build -t ricardojob/app ./app
docker container run -p 8081:8080 --name app -d --link bd:host-banco ricardojob/app
# echo 'fim'
