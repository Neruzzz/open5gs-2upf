#!/bin/bash
source ../.env
docker compose -f ../deployment.yaml up amf ausf bsf mongo nrf nssf pcf scp smf udm udr upf webui