#!/bin/bash

# Script para Automatização de criação de VGs e LVs
# Feito por: Raul Grosmam dos Santos
# Data : 23/07/2019

######################INICIO DO PROGRAMA########################################################################
###########################FUNCOES##############################################################################

###########################CRIAÇÃO DE VG########################################################################

criacao_de_vg()
{
pvs | grep -v PV | awk '{print $1}' | while read NOME
do
LIVRE="`pvs | grep -v PV | grep $NOME | awk '{print $2}'`"
TAM="`pvs | grep -v PV | grep $NOME | awk '{print $5}'`"
if [ "$LIVRE" == "lvm2" ]
   then
   echo "O PV $NOME esta livre, seu tamanho eh de $TAM"
fi
done
echo ""
read -p "Digite o nome da VG a ser criada: " VGC
read -p "Qual PV voce quer usar na criacao da VG? (Nome completo da PV): " PVC
vgcreate $VGC $PVC
}

######################################ALTERAÇÃO DE VG##########################################################

alteracao_de_vg()
{

echo -e "VGs disponiveis:"
vgs | grep -v VG | awk '{print $1}' | while read VGD
do
echo -e "$VGD"
done

echo -e "\nEscolha uma opcao\n"

echo -e "1 - Aumentar o tamanho da VG\n2 - Diminuir o tamanho da VG\n3 - Remover a VG\n0 - Sair\n"

read OPCAOVG

case $OPCAOVG in
1)
read -p "Digite a VG a ser alterada: " VGA
read -p "Digite a PV a ser acrescentada na VG (nome completo da PV): " PVA
vgextend $VGA $PVA
;;

2)
read -p "Digite a VG a ser alterada: " VGA
read -p "Digite a PV a ser removida da VG (nome completo da PV): " PVA
vgreduce $VGA $PVA
;;

3)
read -p "Digite a VG a ser removida: " VGA
vgremove $VGA
;;

0)
echo "Adeus!"
exit 0
;;

*)
echo -e "Comando Invalido, tente novamente"
;;
esac
}

###########################################CRIAÇÃO DE LV###################################################

criacao_de_lv()
{
echo -e "VGs disponiveis:\n"
vgs | grep -v VG | awk '{print $1}' | while read VGD
do
tam="`vgs | grep -v VG | grep $VGD | awk '{print $7}' | cut -d "<" -f 2`"
echo -e "VG: $VGD com espaco livre de: $tam"
done

echo ""

read -p "Voce deseja criar o LV em: 1 - Tamanho ou 2 - Blocos? ou Digite 0 para sair: " TIPO

case $TIPO in

1) read -p "Digite a VG a ser usada: " VGLV
   read -p "Digite o nome da LV: " VGLVNOME
   read -p "Digite o tamanho da LV (Ex: 5G, 3M, etc): " VGLVTAM

   lvcreate -L $VGLVTAM -n $VGLVNOME $VGLV

;;

2) read -p "Digite a VG a ser usada: " VGLV
   read -p "Digite o nome da LV: " VGLVNOME
   read -p "Digite o tamanho da LV em blocos: " VGLVTAM

   lvcreate -l $VGLVTAM -n $VGLVNOME $VGLV
;;

0)
echo "Adeus!"
exit 0
;;

*)
echo -e "Comando Invalido, tente novamente\n"
exit 1
;;

esac

read -p "Digite o nome da pasta que o File System do LV sera montado: " PAS
mkdir -p /$PAS

read -p "Que tipo de File System voce deseja criar? 1 - xfs; 2 - ext3; 3 - ext4: " FILES

case $FILES in

1)
FILES=xfs
;;

2)
FILES=ext3
;;

3)
FILES=ext4
;;

*)

echo "Formato Invalido"
;;

esac

mkfs.$FILES /dev/$VGLV/$VGLVNOME

mount /dev/$VGLV/$VGLVNOME /$PAS

}

###############################################ALTERAÇÃO DE LV################################################

alteracao_de_lv()
{
echo -e "LVs disponiveis:\n"

lvs | grep -v LV | awk '{print $1}' | while read LVA
do
LVVG="`lvs | grep -v LV | grep $LVA | awk '{print $2}'`"
LVTAM="`lvs | grep -v LV | grep $LVA | awk '{print $4}' | cut -d '<' -f 2`"

echo -e "LV: $LVA - VG: $LVVG - tamanho de $LVTAM"
done


echo -e "\nEscolha uma opcao\n"

echo -e "1 - Aumentar o tamanho da LV\n2 - Diminuir o tamanho da LV\n3 - Remover a LV\n0 - Sair\n"

read OPCAOLV

case $OPCAOLV in
1)

read -p "Digite a LV a ter seu tamanho aumentado: " LVAU
read -p "Digite o valor que a LV devera receber: " LVAUTAM
LVVGAU="`lvs | grep -v LV | grep $LVAU | awk '{print $2}'`"

lvextend -L $LVAUTAM -r /dev/$LVVGAU/$LVAU

;;

2)

read -p "Digite a LV a ter seu tamanho reduzido: " LVDM
read -p "Digite o valor que a LV deve ter apos a reducao: " LVDMTAM
LVVGDM="`lvs | grep -v LV | grep $LVDM | awk '{print $2}'`"

lvreduce -L $LVDMTAM /dev/$LVVGDM/$LVDM

;;

3)

read -p "Digite a LV a ser removida: " LVRM
LVVGRM="`lvs | grep -v LV | grep $LVRM | awk '{print $2}'`"
FILESYS="`ls / | df | grep $LVRM | awk '{print $6}'`"


umount /dev/$LVVGRM/$LVRM $FILESYS

lvremove /dev/$LVVGRM/$LVRM

rm -rf $FILESYS

;;

0)
echo "Adeus!"
exit 0
;;

*)
echo -e "Opcao invalida, tente novamente\n"
exit 1

;;
esac
}

###############################CHECKAGEM DE INFORMAÇÕES#############################################

checkagem()
{

tput clear

echo -e "O que voce deseja checkar?\n"
echo -e "1 - Informacoes de PVs\n2 - Informacoes de VGs\n3 - Informacoes de LVs\n0 - Sair" 
read INFOR
case $INFOR in

1)echo -e "Estao disponiveis os PVs\n"
VALORH=2
VALORHS=2
pvdisplay | grep "PV Name" | awk '{print $3}' | while read PVNAME
do

   VGNAME="`pvdisplay | grep Name | awk '{print $3}' | head -$VALORH | tail -1`"
   PVSIZE="`pvdisplay | grep PV | awk '{print $3}' | head -$VALORHS | tail -1 | cut -d "<" -f 2`"

   if [ -z $VGNAME ]
   then
      echo -e "PV: $PVNAME, que nao pertence a nenhuma VG e que tem o tamanho total de: $PVSIZE G"
   else
      echo -e "PV: $PVNAME, pertencente a VG: $VGNAME e que tem o tamanho total de: $PVSIZE G"
   fi
let VALORH=$VALORH+2
let VALORHS=$VALORHS+3
done
;;

2) echo -e "Estao disponiveis os VGs\n"
VALORH=1

vgdisplay | grep "VG Name" | awk '{print $3}' | while read VGNAME
do
   VGSIZE="`vgs | grep -v VG | grep $VGNAME | awk '{print $6}' | cut -d '<' -f 2`"
   echo -e "VG: $VGNAME - Tamanho: $VGSIZE "
let VALORH=$VALORH+1
done
;;

3) echo -e "Estao disponiveis os LVs\n"
VALORH=2
VALORHP=1
VALORHT=7
lvdisplay | grep "LV Name" | awk '{print $3}' | while read LVNOME
do
   VGNAME="`lvdisplay | grep Name | awk '{print $3}' | head -$VALORH | tail -1`"
   LVPATH="`lvdisplay | grep LV | awk '{print $3}' | head -$VALORHP | tail -1`"
   LVTAM="`lvs | grep -v LV | grep $LVNOME | awk '{print $4}' | cut -d "<" -f 2`"
   LVP="`ls -l | df | grep $LVNOME | awk '{print $6}'`"
   TFS="`ls -l / | df -Th | grep $LVNOME | awk '{print $2}'`"

   echo -e "LV: $LVNOME\nVG: $VGNAME\nTamanho: $LVTAM\nCaminho da LV: $LVPATH\nEsta montado em: $LVP\nTipo de File System: $TFS\n"

let VALORH=$VALORH+2
let VALORHP=$VALORHP+7
let VALORHT=$VALORHT+7
done
;;

0)
echo "Adeus!"
exit 0
;;

*)
echo -e "Opcao Invalida, tente novamente\n"
;;

esac

}

#####################################################INICIO DO MENU################################################################

tput clear
LOOP=1

while [ $LOOP -gt 0 ]
do

echo "Escolha uma das opcoes"

echo -e "1 - Criacao de VG\n2 - Alteracao de VG\n3 - Criacao de LV\n4 - Alteracao de LV\n5 - Checkagem de Informacoes\n0 - Sair\n"

read OPCAO
case $OPCAO in

1) tput clear
   echo "Voce Escolheu Criacao de VG"
   criacao_de_vg ;;

2) tput clear
   echo -e "Voce escolheu Alteracao de VG\n"
   alteracao_de_vg ;;

3) tput clear
   echo -e "Voce Escolheu Criacao de LV\n" 
   criacao_de_lv ;;

4) tput clear 
   echo -e "Voce Escolheu Alteracao de LV\n"
   alteracao_de_lv ;;

5) tput clear
   echo "Voce Escolheu Checkagem"
   checkagem ;;
0) echo "Adeus!"
   exit 0   ;;
*) echo -e "Opcao invalida, tente novamente\n" ;;
esac

echo "Deseja fazer outra operacao?"
read -p "1 - Sim; 0 - Nao: " LOOPI

case $LOOPI in

1) tput clear
;;

*) echo "Adeus!"
LOOP=0
;;
esac
done
