#!/bin/bash
# Build docker images for open5gs EPC/5GC components
cd base
docker build --no-cache --force-rm -t docker_open5gs .


cd ..
set -a
source .env
docker compose -f sa-deploy.yaml build
