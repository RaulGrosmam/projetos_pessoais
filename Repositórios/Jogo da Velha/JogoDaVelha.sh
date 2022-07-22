#!/bin/bash

#Script feito por: Raul Grosmam dos Santos
#Data            : 01/08/2019
#Funcionalidade  : Apenas um jogo da velha

################################################################################################################################
############################################# FUNÇÕES #########################################################################

design()
{
LINHAS=0

tput clear

LINHA=15
COLUNA=65

while [ $LINHAS -eq 0 ]
do

tput cup $LINHA $COLUNA
echo "_"

let COLUNA=$COLUNA+1
   if [ $COLUNA -gt 77 ]
   then
      let LINHA=$LINHA+2
      COLUNA=65
   fi

   if [ $LINHA -gt 18 ]
   then
      LINHAS=1
   fi
done

COLUNAS=0

LINHA=14
COLUNA=69

while [ $COLUNAS -eq 0 ]
do
tput cup $LINHA $COLUNA

echo "|"

let COLUNA=$COLUNA+4
   if [ $COLUNA -gt 73 ]
   then
      let LINHA=$LINHA+1
      let COLUNA=69
   fi

   if [ $LINHA -gt 19 ]
   then
      COLUNAS=1
   fi
done
}


posicoes()
{
V1=0;V2=0;V3=0;V4=0;V5=0;V6=0;V7=0;V8=0;V9=0
LOOP=1

while [ $LOOP -lt 10 ]
do

LOOP2=1

while [ $LOOP2 -gt 0 ]
do

tput cup 25 0
echo -e "                                                                         \c"
tput cup 25 0
echo -e "Vez de $J1 [X]: \c"
read VALOR
echo "                                           "

case $VALOR in

1) if [ $V1 -eq 0 ]
   then
      V1=4
      tput cup 14 67
      echo "X"
      let LOOP=$LOOP+1
      LOOP2=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

2) if [ $V2 -eq 0 ]
   then
      V2=4
      tput cup 14 71
      echo "X"
      let LOOP=$LOOP+1
      LOOP2=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

3) if [ $V3 -eq 0 ]
   then

      V3=4
      tput cup 14 75
      echo "X"
      let LOOP=$LOOP+1
      LOOP2=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;
   
4) if [ $V4 -eq 0 ]
   then
      V4=4
      tput cup 16 67
      echo "X"
      let LOOP=$LOOP+1
      LOOP2=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

5) if [ $V5 -eq 0 ]
   then
      V5=4
      tput cup 16 71
      echo "X"
      let LOOP=$LOOP+1
      LOOP2=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

6) if [ $V6 -eq 0 ]
   then
      V6=4
      tput cup 16 75
      echo "X"
      let LOOP=$LOOP+1
      LOOP2=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;


7) if [ $V7 -eq 0 ]
   then
      V7=4
      tput cup 18 67
      echo "X"
      let LOOP=$LOOP+1
      LOOP2=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;
   
8) if [ $V8 -eq 0 ]
   then
      V8=4
      tput cup 18 71
      echo "X"
      let LOOP=$LOOP+1
      LOOP2=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

9) if [ $V9 -eq 0 ]
   then
      V9=4
      tput cup 18 75
      echo "X"
      let LOOP=$LOOP+1
      LOOP2=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

*) tput cup 25 30
   echo -e "Valor Invalido\c"
   sleep 2
   tput cup 25 30
   echo -e "                                      \c"
   ;;
esac
done

let LINHA1=$V1+$V2+$V3
let LINHA2=$V4+$V5+$V6
let LINHA3=$V7+$V8+$V9
let COLUNA1=$V1+$V4+$V7
let COLUNA2=$V2+$V5+$V8
let COLUNA3=$V3+$V6+$V9
let DIAGONAL1=$V1+$V5+$V9
let DIAGONAL2=$V3+$V5+$V7

if [ $LINHA1 -eq 12 ] || [ $LINHA2 -eq 12 ] || [ $LINHA3 -eq 12 ] || [ $COLUNA1 -eq 12 ] || [ $COLUNA2 -eq 12 ] || [ $COLUNA3 -eq 12 ] || [ $DIAGONAL1 -eq 12 ] || [ $DIAGONAL2 -eq 12 ]
then
   echo "$J1 é o VENCEDOR!!!!"
   LOOP=10
   exit 0
fi   

if [ $LOOP -gt 8 ]
then
   echo "DEU VELHA!!! NINGUÉM VENCEU!!!"
   exit 0
fi

LOOP3=1
while [ $LOOP3 -gt 0 ]
do
tput cup 25 0
echo -e "                                                                         \c"
tput cup 25 0
echo -e "Vez de $J2 [O]: \c"
read VALOR
echo -e "                                           \c"

case $VALOR in

1) if [ $V1 -eq 0 ]
   then
      V1=1
      tput cup 14 67
      echo "O"
      let LOOP=$LOOP+1
      LOOP3=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

2) if [ $V2 -eq 0 ]
   then
      V2=1
      tput cup 14 71
      echo "O"
      let LOOP=$LOOP+1
      LOOP3=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

3) if [ $V3 -eq 0 ]
   then
      V3=1
      tput cup 14 75
      echo "O"
      let LOOP=$LOOP+1
      LOOP3=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

4) if [ $V4 -eq 0 ]
   then
      V4=1
      tput cup 16 67
      echo "O"
      let LOOP=$LOOP+1
      LOOP3=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

5) if [ $V5 -eq 0 ]
   then
      V5=1
      tput cup 16 71
      echo "O"
      let LOOP=$LOOP+1
      LOOP3=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

6) if [ $V6 -eq 0 ]
   then
      V6=1
      tput cup 16 75
      echo "O"
      let LOOP=$LOOP+1
      LOOP3=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

7) if [ $V7 -eq 0 ]
   then
      V7=1
      tput cup 18 67
      echo "O"
      let LOOP=$LOOP+1
      LOOP3=0
      tput cup 25 0
   else
	   tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"
   fi
   ;;

8) if [ $V8 -eq 0 ]
   then
      V8=1
      tput cup 18 71
      echo "O"
      let LOOP=$LOOP+1
      LOOP3=0
      tput cup 25 0
   else
      tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"
   fi
   ;;

9) if [ $V9 -eq 0 ]
   then
      V9=1
      tput cup 18 75
      echo "O"
      let LOOP=$LOOP+1
      LOOP3=0
      tput cup 25 0
   else
      tput cup 25 30
   echo "Local já preenchido "
   sleep 2
   tput cup 25 30
   echo -e "                      \c"

   fi
   ;;

*) tput cup 25 30
   echo "Valor Invalido"
   sleep 2
   tput cup 25 30
   echo -e "                      \c"
   ;;
esac

let LINHA1=$V1+$V2+$V3
let LINHA2=$V4+$V5+$V6
let LINHA3=$V7+$V8+$V9
let COLUNA1=$V1+$V4+$V7
let COLUNA2=$V2+$V5+$V8
let COLUNA3=$V3+$V6+$V9
let DIAGONAL1=$V1+$V5+$V9
let DIAGONAL2=$V3+$V5+$V7

if [ $LINHA1 -eq 3 ] || [ $LINHA2 -eq 3 ] || [ $LINHA3 -eq 3 ] || [ $COLUNA1 -eq 3 ] || [ $COLUNA2 -eq 3 ] || [ $COLUNA3 -eq 3 ] || [ $DIAGONAL1 -eq 3 ] || [ $DIAGONAL2 -eq 3 ]
then
    echo "$J2 é o VENCEDOR!!!!"        
    LOOP=10
    exit 0
fi
done

done
}
###########################################################INICIO DO JOGO#####################################################################
tput clear

LOOPJ1=1
LOOPJ2=1

while [ $LOOPJ1 -gt 0 ]
do
read -p "Digite o nome do jogador 1 [X]: " J1
   if [ -z $J1 ]
   then
      tput cup 0 0
      echo -e "O campo nao pode estar vazio, tente novamente\c"
      sleep 3
      tput cup 0 0
      echo "                                                           "
      tput cup 0 0
   else
      LOOPJ1=0
   fi
done

while [ $LOOPJ2 -gt 0 ]
do
read -p "Digite o nome do jogador 2 [O]: " J2
   if [ -z $J2 ]
   then
      tput cup 1 0
      echo -e "O campo nao pode estar vazio, tente novamente\c"
      sleep 3
      tput cup 1 0
      echo "                                                           "
      tput cup 1 0

   else
      LOOPJ2=0
   fi
done



design

tput cup 12 49
echo "Jogador [X]: $J1                 Jogador [O]: $J2"

posicoes
tput cup 35 0







