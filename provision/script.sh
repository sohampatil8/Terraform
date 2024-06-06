#!/bin/bash
sudo yum install nginx -y
sudo echo "Hey Boy! Do you wanna freak me." > /usr/share/nginx/html/index.html
sudo systemctl start nginx