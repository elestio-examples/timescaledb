#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./data;
mkdir -p ./pgadmin;

chown -R 1001:1001 ./data;
chown -R 1001:1001 ./pgadmin;

cat <<EOT > ./servers.json
{
    "Servers": {
        "1": {
            "Name": "local",
            "Group": "Servers",
            "Host": "172.17.0.1",
            "Port": 5432,
            "MaintenanceDB": "postgres",
            "SSLMode": "prefer",
            "Username": "postgres",
            "PassFile": "/pgpass"
        }
    }
}
EOT

docker-compose up -d;
sleep 20s;
docker-compose down
sed -i 's/#command:/command:/' docker-compose.yml

openssl req -new -x509 -days 3650 -nodes -text -out ./data/server.crt -keyout ./data/server.key -subj "/CN=${CNAME}"
