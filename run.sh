#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "O script foi suspenso pois o usuário deve ser ROOT!"
  exit
fi

cd /

dir_list=("/publico" "/adm" "/ven" "/sec")
for item in ${dir_list[@]}; do
  rm -Rf $item/
  mkdir $item
done

usr_list=("carlos" "GRP_ADM" "maria" )
for item in ${usr_list[@]}; do
  userdel -r $item 
  useradd $item -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM 
done

grp_list=("GRP_ADM" "GRP_VEN" "GRP_SEC")
for item in ${usr_list[@]}; do
  groupdel $item
  groupadd $item
done



echo "Script finalizado com sucesso."
