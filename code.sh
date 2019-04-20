#!/bin/bash

# install code
# paths
mp='/home/lnxdork/Downloads/'

# install code
# https://vscode-update.azurewebsites.net/latest/linux-rpm-x64/stable
wget -P ${mp}code/ https://go.microsoft.com/fwlink/?LinkID=760867
mv ${mp}code/* code.rpm
sudo dnf install ${mp}code/code.rpm
