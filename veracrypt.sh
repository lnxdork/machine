#!/bin/bash

# install veracrypt
# paths
mp='/home/lnxdork/Downloads/'

# install veracrypt
wget -P ${mp}veracrypt/ https://launchpad.net/veracrypt/trunk/1.23/+download/veracrypt-1.23-setup.tar.bz2 
wget -P ${mp}veracrypt/ https://launchpad.net/veracrypt/trunk/1.23/+download/veracrypt-1.23-setup.tar.bz2.sig
wget -P /${mp}veracrypt/ https://www.idrix.fr/VeraCrypt/VeraCrypt_PGP_public_key.asc

gpg --with-fingerprint ${mp}veracrypt/VeraCrypt_PGP_public_key.asc
if [ $? -eq 0 ]
then
	echo "${green}fingerprint is good, importing key${reset}"
	gpg --import ${mp}veracrypt/VeraCrypt_PGP_public_key.asc
	gpg --verify ${mp}veracrypt/veracrypt-1.23-setup.tar.bz2.sig ${mp}veracrypt/veracrypt-1.23-setup.tar.bz2
	if [ $? -eq 0 ]
	then
		echo "${green}signature is good, unpacking files${reset}"
		tar -xjvf ${mp}veracrypt/veracrypt-1.23-setup.tar.bz2 -C ${mp}veracrypt/
	else
		echo "${red}signature is bad, skipping install${reset}"
	fi
else
	echo "${red}fingerprint is bad, skipping key${reset}"
fi   