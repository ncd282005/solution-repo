#!/bin/bash

echo "CPU usage:"
top

echo "Memory usage:"
free -h

echo "Disk usage:"
df -h

echo "Top 5 CPU usages:"
ps aux | sort -rk 3,3 | head -5

echo "Top 5 Memory usages:"
ps aux | sort -rk 4,4 | head -5