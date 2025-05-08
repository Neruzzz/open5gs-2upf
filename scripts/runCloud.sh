#!/bin/bash
source ../.env
docker compose -f ../sa-two-slices-deploy.yaml up amf ausf bsf mongo nrf nssf pcf scp smf udm udr upf webui