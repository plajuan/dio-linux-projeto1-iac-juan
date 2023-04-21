#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "O script foi suspenso pois o usuário deve ser ROOT!"
  exit
fi

cd /

dir_list=("/adm" "/ven" "/sec" "/publico")
grp_list=("GRP_ADM" "GRP_VEN" "GRP_SEC")
declare -A usr_list
usr_list['carlos']=${grp_list[0]}
usr_list['maria']=${grp_list[0]}
usr_list['joao']=${grp_list[0]}

usr_list['debora']=${grp_list[1]}
usr_list['sebastiana']=${grp_list[1]}
usr_list['roberto']=${grp_list[1]}

usr_list['josefina']=${grp_list[2]}
usr_list['amanda']=${grp_list[2]}
usr_list['rogerio']=${grp_list[2]}

echo "Deletando os diretórios"
for item in ${dir_list[@]}; do
  rm -Rf $item/  
done
echo "Deletando os grupos"
for item in ${grp_list[@]}; do
  groupdel $item  
done
echo "Deletando as pessoas"
for item in ${!usr_list[@]}; do
  userdel -r $item
done

echo "Criando os diretórios"
for item in ${dir_list[@]}; do  
  mkdir $item
done

echo "Criando os grupos"
for item in ${grp_list[@]}; do
  groupadd $item
done

senha=""
echo "Criando as pessoas e adicionando os grupos"
for item in ${!usr_list[@]}; do
  useradd $item -m -s /bin/bash -G ${usr_list[$item]}
  echo -e "$senha\n$senha" | passwd $item
done

echo "Atribuindo permissões aos diretórios"
for item in ${!grp_list[@]}; do
  chown root:${grp_list[$item]} ${dir_list[$item]}
  chmod 770 ${dir_list[$item]}
done

chmod 777 ${dir_list[3]}

echo "Script finalizado com sucesso."
