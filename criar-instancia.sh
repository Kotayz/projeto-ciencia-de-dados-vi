#!/bin/bash

tipoPlano=""
name=""
lastName=""
container=""
randomId=$$
elastico=0
ramIni=""
pauseStart="Pausar"
randomId2=$(date +%s)
#Inicio do Gerador de Nomes 'Quase Aleatórios'
idName=$(($randomId%5))
idLastName=$((($randomId2)%5))

if [ $idName -eq 0 ]
then
	name="Crow"
elif [ $idName -eq 1 ]
then
	name="Wolf"
elif [ $idName -eq 2 ]
then
	name="Squirrel"
elif [ $idName -eq 3 ]
then
	name="Cow"
elif [ $idName -eq 4 ]
then
	name="Bear"
fi

if [ $idLastName -eq 0 ]
then
	lastName="Crazy"
elif [ $idLastName -eq 1 ]
then
	lastName="Tired"
elif [ $idLastName -eq 2 ]
then
	lastName="Hungry"
elif [ $idLastName -eq 3 ]
then
	lastName="Unemployed"
elif [ $idLastName -eq 4 ]
then
	lastName="Drunk"
fi

container=$name$"-"$lastName$randomId

#Fim  do Gerador de Nomes 'Quase Aleatórios'

#------------------------------------------------------------------------#

#inicio da criação do perfil de acordo com a opção escolhida

printf "Escolha um perfil para criar uma instancia: \n"
printf "[1] Basic\n[2] Standard\n[3] Premium\n"

read response

if [ $response -eq 1 ]
then
	echo "Criando container basic"
	lxc launch ubuntu:18.04 $container -p default -p basic
	tipoPlano="Basic"
	ramIni="512MB"
elif [ $response -eq 2 ]
then
	echo "Criando container standard"
	lxc launch ubuntu:18.04 $container -p default -p standard
	tipoPlano="Standart"
	ramIni="1GB"
elif [ $response -eq 3 ]
then
	echo "Criando container premium"
	lxc launch ubuntu:18.04 $container -p default -p premium
	tipoPlano="Premium"
	ramIni="3GB"	
else
    echo "opção invalida"
fi

echo ""
echo ""
echo ""
echo ""
echo ""
echo "Conteiner Criado!"
echo ""
echo "Exibindo Detalhes do Container "$container$" no Plano "$tipoPlano$":"
echo ""
lxc list -c ns,limits.memory:MEM,limits.cpu:CPU,mMuDc

lxc exec $container tmate -S /tmp/tmate.socket new-session -d	

#fim da criação o perfil de acordo com a opção escolhida



while :
do
printf  "Opções: \n"
if [ $elastico -eq 0 ]
then

	printf  "

	[1] Exibir Informações do Container
	[2] Listar Arquivos
	[3] Gerar Link de Acesso ao Conteiner(tmate)*
	[4] Solicitar Elasticidade
	[9] "$pauseStart$" Container
	[0] Encerar e Sair
	
	*Opções ainda não implementadas
	
	\n"

else
	printf  "

	[1] Exibir Informações do Container
	[2] Listar Arquivos
	[3] Gerar Link de Acesso ao Conteiner(tmate)*
	[4] Solicitar Elasticidade
	[5] Encerrar Elasticidade
	[9] "$pauseStart$" Container	
	[0] Encerrar e Sair
	
	*Opções ainda não implementadas
	
	\n"

fi	
  read INPUT_STRING
  case $INPUT_STRING in

	1)
		lxc exec $container htop

		;;
	2)
		lxc ls
		
		;;
	3)
		lxc exec $container tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'
		
		;;						

	4)
		echo "Informe a quantidade de GB que deseja solicitar?"
		read qtdGigas
		if [[ ${qtdGigas} =~ ^([0-9]+)$ ]];then
			if [ $qtdGigas -lt 1 ]
			then
				echo "A quantidade deve ser superior a 0(zero)"
				
			elif [ $qtdGigas -gt 100 ]
			then
				echo "Para quantidades superiores a 100GB entre em contato com nossa equipe para consultar valores e condiçoes diferenciadas"

			else
			    echo "Aumento para "$qtdGigas$"GB de RAM para o container "$container$"."
			    lxc config set $container limits.memory $qtdGigas$"GB"
			    printf "\nExibindo configurações atualizadas:\n"
			    lxc list -c ns,limits.memory:MEM,limits.cpu:CPU,mMuDc
			    elastico=1
			fi
		else

			printf "Deve ser informado apenas numeros."
			printf "Voltando ao menu de opções...\n"
			
		fi
			
		;;
	5)
		if [ $elastico -eq 1 ]
		then
			echo "Normalização de RAM para o container "$container$"."
			lxc config set $container limits.memory $ramIni
			printf "\nExibindo configurações atualizadas:\n"
			lxc list -c ns,limits.memory:MEM,limits.cpu:CPU,mMuDc
			elastico=0
		fi
		;;
	9)
		if [ $pauseStart == "Pausar" ]
		then
			lxc stop $container
			pauseStart="Iniciar"
		else
			lxc start $container
			pauseStart="Pausar"		
		fi
		;;				
	0)
		echo "Encerrando o Container "$container$"."
		break
		;;				
				
	*)
		echo "Opção Inválida"
		;;		
  esac
done
echo 
echo "Tempo de execução do Container "$container$"."
lxc exec $container uptime
lxc delete -f $container
echo "Container "$container$" deletado."
















