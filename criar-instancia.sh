#!/bin/bash

echo "Escolha um perfil para criar uma instancia: \n"
echo "[1] Basic \n[2] Standard \n[3] Premium\n"

read response

if [ $response -eq 1 ]
then
    echo "Criando container basic"
	lxc launch ubuntu:18.04 -p default -p basic
elif [ $response -eq 2 ]
then
	echo "Criando container standard"
	lxc launch ubuntu:18.04 -p default -p standard
elif [ $response -eq 3 ]
then
	echo "Criando container premium"
	lxc launch ubuntu:18.04 -p default -p premium
else
    echo "opção invalida"
fi
