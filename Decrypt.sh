#!/bin/bash

# Set variables
key_name="my_key"
passphrase="your_passphrase_here"
received_encrypted_file="encrypted_data.enc"

# Navigate to the encryption_scenario folder
cd encryption_scenario

# Decrypt the encrypted file using private key
openssl enc -d -aes256 -in "$received_encrypted_file" -out decrypted_data.txt -pass file:"$key_name".pub

# Display decrypted data
cat decrypted_data.txt

# Clean up (optional)
#rm "$received_encrypted_file" "$key_name".pub decrypted_data.txt
