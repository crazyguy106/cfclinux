#!/bin/bash

echo "Hello! This is my first ever script!"
echo "My external ip is"
curl ifconfig.me
echo
echo "My internal ip is"
ifconfig | grep broadcast | awk '{print $2}'
echo "My defult gateway is"
route -n | grep UG | awk '{print $2}'
