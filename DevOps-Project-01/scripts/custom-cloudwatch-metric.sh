#!/bin/bash
while true; do
  memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
  aws cloudwatch put-metric-data --metric-name MemoryUsage --namespace Custom --value $memory_usage --dimensions InstanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id)
  sleep 60
done &