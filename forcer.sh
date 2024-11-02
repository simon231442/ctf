#!/bin/bash

# Variables
zip_file="protected.zip"    # The zip file you want to crack
password_list="passwords.txt"  # File with list of passwords

# Check if both files exist
if [[ ! -f "$zip_file" ]]; then
  echo "Error: Zip file '$zip_file' not found."
  exit 1
fi

if [[ ! -f "$password_list" ]]; then
  echo "Error: Password list file '$password_list' not found."
  exit 1
fi

# Loop through each password in the password list
while IFS= read -r password; do
  echo "Trying password: $password"

  # Try to unzip with the current password
  if unzip -P "$password" -t "$zip_file" &>/dev/null; then
    echo "Success! Password is: $password"
    # Optionally extract the files
    unzip -P "$password" "$zip_file" -d extracted_files
    exit 0
  fi
done < "$password_list"

echo "Password not found in the list."
exit 1

