#!/bin/sh

cd sdw1
docker build -t sdw1_base .
echo "sdw1_base image built"
cd ..
cd sdw2
docker build -t sdw2_base .
echo "sdw2_base image built"
cd ..
cd sdw3
docker build -t sdw3_base .
echo "sdw3_base image built"
cd ..
cd sdw4
docker build -t sdw4_base .
echo "sdw4_base image built"

docker run --name sdw1 -d -p 5000:5000 sdw1_base
docker run --name sdw2 -d -p 5001:5001 sdw2_base
docker run --name sdw3 -d -p 5002:5002 sdw3_base
docker run --name sdw4 -d -p 5003:5003 sdw4_base
echo "sdw1..4 is now running"

docker network create 369-network
docker network connect 369-network sdw1
docker network connect 369-network sdw2
docker network connect 369-network sdw3
docker network connect 369-network sdw4
echo "sdw1..4 is connected to 369-network"

gnome-terminal -- bash -c "echo [This terminal is attached to sdw1]; docker attach sdw1; exec bash"
gnome-terminal -- bash -c "echo [This terminal is attached to sdw2]; docker attach sdw2; exec bash"
gnome-terminal -- bash -c "echo [This terminal is attached to sdw3]; docker attach sdw3; exec bash"
gnome-terminal -- bash -c "echo [This terminal is attached to sdw4]; docker attach sdw4; exec bash"

echo "369 starts in 3.."
sleep 1s
echo "369 starts in 2.."
sleep 1s
echo "369 starts in 1.."
sleep 1s

curl "http://localhost:5000/start"

echo "to start 369 again -> curl http://localhost:5000/start"
echo "to delete everything generated with main.sh -> sh deleteAll.sh"
