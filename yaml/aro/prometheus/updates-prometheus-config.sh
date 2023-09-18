#!/bin/bash
oc create secret generic additional-scrape-configs --from-file=conf/prometheus-additional.yaml --dry-run=client -oyaml > 05_additional-scrape-configs.yaml
