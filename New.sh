#!/bin/bash

# Set variables for Device A
data="This is a secret message.ROUND TWO, VALHAR DOHAERIS "
folder_name="encryption_scenario"
key_name="my_key"
passphrase="your_passphrase_here"
encrypted_file="encrypted_data.enc"
signature="data_signature.sig"
remote_ip="192.168.56.108"

# Create folder
mkdir -p "$folder_name"
cd "$folder_name"

# Generate asymmetric key pair
openssl genpkey -algorithm RSA -out "$key_name".key -aes256 -pass pass:"$passphrase"
openssl rsa -in "$key_name".key -pubout -out "$key_name".pub -passin pass:"$passphrase"

# Encrypt data
echo "$data" > plain_data.txt
openssl enc -aes256 -salt -in plain_data.txt -out "$encrypted_file" -pass file:"$key_name".pub

# Generate digital signature
openssl dgst -sha256 -sign "$key_name".key -passin pass:"$passphrase" -out "$signature" "$encrypted_file"

# Send public key, encrypted file, and signature to Device B
scp "$key_name".pub "$encrypted_file" "$signature" kali@"$remote_ip":new/encryption_scenario/

# Clean up (optional)
#rm "$key_name".key plain_data.txt "$encrypted_file" "$signature"
