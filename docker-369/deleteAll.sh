#!/bin/bash

docker stop sdw1 sdw2 sdw3 sdw4
docker rm sdw1 sdw2 sdw3 sdw4
docker rmi sdw1_base sdw2_base sdw3_base sdw4_base
docker network rm 369-network
echo "all deleted!"
