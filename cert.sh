#!/bin/bash
echo -e "Hello! My name is Friday.\nI assist you to create private key and csr file."
echo ""
echo "Script Information"
echo "author_name: Vusal Karimov"
echo "author_email: https://gitlab.com/vusal.karimov"
echo "author_gitlab_repo: https://gitlab.com/vusal.karimov"
echo "description: This script helps you to create a private key and csr file using "openssl" command."
echo "vesion: 1.0.0"
echo ""
echo "Let's begin."
echo ""
read -p "Enter directory name to store key and csr files: " dir
dir_name=${dir}_cert_files
if [ -d $dir_name ]; then
  echo "${dir_name} is exists. Enter other name."
  read -p "Enter directory name to store key and csr files: " dir
  dir_name=${dir}_cert_files
  mkdir ${dir_name}
else
  mkdir ${dir_name}
  echo "${dir_name} is created"
fi
read -p "Enter file name for key and csr files: " file_name
read -p "Enter the domain name: " domain_name
while true; do
  read -p "Do you want to add Subject Alternative Name (SAN) field? y|n " answer
  shopt -s nocasematch
  case ${answer} in
    y|yes)
    read -p "How many SAN do you want to add? 1|2 " count
    case $count in
      1)
      read -p "Enter the dns1: " dns1
      openssl req -newkey rsa:2048 -noenc -keyout ${file_name}.key -out ${file_name}.csr \
      -subj "/C=AZ/ST=BAKU/L=BAKU/O=VXSIDA/OU=IT/CN=${domain_name}" \
      -addext "subjectAltName = DNS:${dns1}"
      mv ${file_name}.* ./${dir_name}
      exit 0
      ;;
      2)
      read -p "Enter the dns1: " dns1
      read -p "Enter the dns2: " dns2
      openssl req -newkey rsa:2048 -noenc -keyout ${file_name}.key -out ${file_name}.csr \
      -subj "/C=AZ/ST=BAKU/L=BAKU/O=VXSIDA/OU=IT/CN=${domain_name}" \
      -addext "subjectAltName = DNS:${dns1},DNS:${dns2}"
      mv ${file_name}.* ./${dir_name}
      exit 0
      ;;
      *)
      echo "Invalid option."
      continue
    esac
    ;;  
    n|no)
    openssl req -newkey rsa:2048 -noenc -keyout ${file_name}.key -out ${file_name}.csr \
    -subj "/C=AZ/ST=BAKU/L=BAKU/O=VXSIDA/OU=IT/CN=${domain_name}"
    mv ${file_name}.* ./${dir_name}
    exit 0
    ;;
    *)
    echo "Invalid option."
    continue
  esac
done



