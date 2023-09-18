#!/bin/bash
oc create secret generic additional-scrape-configs --from-file=conf/prometheus-additional.yaml --dry-run=client -o yaml > 05_additional-scrape-configs.yml
