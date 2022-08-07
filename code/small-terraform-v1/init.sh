#!/bin/bash

sudo apt install nginx -y
echo ${content} | sudo tee /var/www/html/index.html
sudo systemctl restart nginx
