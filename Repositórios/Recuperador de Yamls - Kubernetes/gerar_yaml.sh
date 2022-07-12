#!/bin/bash

# Script para automatização de geração de YAML dos AKS's
# Feito por: Raul Grosmam dos Santos
# Data: 18/04/2022

############################################## INICIO DO SCRIPT #######################################################

##############################################   FUNCÕES    ###########################################################

############################################# CRIAÇÃO DAS PASTAS DE NAMESPACES ########################################

cricao_pastas_ns()
{  
kubectl get ns | grep -v NAME | cut -d " " -f 1 > ns

for PNS in `cat ./ns`
do
   mkdir -p $CLUSTER/namespaces/$PNS/cronjobs
   mkdir -p $CLUSTER/namespaces/$PNS/statefulsets
   mkdir -p $CLUSTER/namespaces/$PNS/deployments
   mkdir -p $CLUSTER/namespaces/$PNS/services
   mkdir -p $CLUSTER/namespaces/$PNS/daemonsets
   mkdir -p $CLUSTER/namespaces/$PNS/secrets
   mkdir -p $CLUSTER/namespaces/$PNS/configmaps
   
done
}

################################################# CRIAÇÃO DOS YAMLS DE CRONJOBS DOS NAMESPACES ##############################

criacao_de_cronjob()
{
for NS in `cat ./ns`
do
   for CJs in `kubectl get all -A | grep cronjob | grep $NS | awk '{print $2}' | cut -d "/" -f 2`
   do 
      kubectl -n $NS get cronjob $CJs -o yaml | kubectl neat > $CLUSTER/namespaces/$NS/cronjobs/$CJs.yaml
   done
done
}

############################################ CRIAÇÃO DOS YAMLS DE STATEFULSETS DOS NAMESPACES ###############################

criacao_de_sts()
{
for NS in `cat ./ns`
do
   for STSs in `kubectl get all -A | grep statefulset | grep $NS | awk '{print $2}' | cut -d "/" -f 2`
   do 
      kubectl -n $NS get sts $STSs -o yaml | kubectl neat > $CLUSTER/namespaces/$NS/statefulsets/$STSs.yaml
   done
done
} 

############################################ CRIAÇÃO DOS YAMLS DE DEPLOYMENTS DOS NAMESPACES ###############################

criacao_de_deployment()
{
for NS in `cat ./ns`
do
   for DMs in `kubectl get all -A | grep deployment | grep $NS | awk '{print $2}' | cut -d "/" -f 2`
   do 
      kubectl -n $NS get deployment $DMs -o yaml | kubectl neat > $CLUSTER/namespaces/$NS/deployments/$DMs.yaml
   done
done
} 

############################################ CRIAÇÃO DOS YAMLS DE SERVICES DOS NAMESPACES ###############################

criacao_de_services()
{
for NS in `cat ./ns`
do
   for SERVICEs in `kubectl get all -A | grep service | grep $NS | awk '{print $2}' | cut -d "/" -f 2`
   do 
      kubectl -n $NS get service $SERVICEs -o yaml | kubectl neat > $CLUSTER/namespaces/$NS/services/$SERVICEs.yaml
   done
done
} 

############################################ CRIAÇÃO DOS YAMLS DE DAEMONSETS DOS NAMESPACES ###############################

criacao_de_daemonset()
{
for NS in `cat ./ns`
do
   for DSs in `kubectl get all -A | grep daemonset | grep $NS | awk '{print $2}' | cut -d "/" -f 2`
   do 
      kubectl -n $NS get daemonset $DSs -o yaml | kubectl neat > $CLUSTER/namespaces/$NS/daemonsets/$DSs.yaml
   done
done
} 

############################################ CRIAÇÃO DOS YAMLS DE CONFIGMAPS DOS NAMESPACES ###############################

criacao_de_configmap()
{
for NS in `cat ./ns`
do
   for CMs in `kubectl get configmaps -A | grep $NS | awk '{print $2}' | cut -d "/" -f 2`
   do 
      kubectl -n $NS get configmaps $CMs -o yaml | kubectl neat > $CLUSTER/namespaces/$NS/configmaps/$CMs.yaml
   done
done
} 

############################################ CRIAÇÃO DOS YAMLS DE SECRETS DOS NAMESPACES ###############################

criacao_de_secret()
{
for NS in `cat ./ns`
do
   for SCs in `kubectl get secrets -A | grep $NS | awk '{print $2}' | cut -d "/" -f 2`
   do 
      kubectl -n $NS get secrets $SCs -o yaml | kubectl neat > $CLUSTER/namespaces/$NS/secrets/$SCs.yaml
   done
done
} 

########################################### LIMPEZA DE LIXO ##############################################################

limpeza_de_lixo()
{
find $CLUSTER -type d -empty -delete
rm -rf ns
}

########################################### EXECUCAO DO PROGRAMA #########################################################

tput clear

CLUSTER=`kubectl config get-contexts | grep \* | awk '{print $2}'`

echo "Criando pastas"
cricao_pastas_ns

echo "Iniciando criacao dos YAMLs"

echo "Criando YAMLs de Cronjobs"
criacao_de_cronjob 2>/dev/null

echo "Criando YAMLs de Statefulsets"
criacao_de_sts 2>/dev/null

echo "Criando YAMLs de Deployments"
criacao_de_deployment 2>/dev/null

echo "Criando YAMLs de Services"
criacao_de_services 2>/dev/null

echo "Criando YAMLs de Daemonsets"
criacao_de_daemonset 2>/dev/null

echo "Criando YAMLs de Configmaps"
criacao_de_configmap 2>/dev/null

echo "Criando YAMLs de Secrets"
criacao_de_secret 2>/dev/null

echo "Limpando residuos"
limpeza_de_lixo

echo "YAMLs criados com sucesso"
