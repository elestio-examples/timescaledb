#nothing to do

docker-compose down
openssl req -new -x509 -days 3650 -nodes -text -out ./data/server.crt -keyout ./data/server.key -subj "/CN=${CNAME}"
# sed --debug -i 's/#//g' ./docker-compose.yml
sleep 5s;
sed --debug  -i '/^\s*# command/s/# //' ./docker-compose.yml
docker-compose up -d;
