#!/bin/bash

echo "The following commands will be executed:"
echo ""
echo "sudo add-apt-repository ppa:<ppa-to-add>"
echo "sudo apt update"

read -p "Enter PPA (e.g. olive-editor/olive-editor): " ppa
sudo add-apt-repository ppa:$ppa
sudo apt update

echo "ppa:$ppa has been added"
