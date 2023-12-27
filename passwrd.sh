#!/bin/bash

ID=$(id -u)

if [ ${ID} -ne 0 ]; then
    echo "Please switch to root user"
    exit 1
else
    echo "You are a root user"
fi

validate() {
    if [ $1 -ne 0 ]; then
        echo "$2 .....Creation failed"
        exit 1
    else
        echo "$2 ......Creation Success"
    fi
}

echo "Adding New User"

read -p "Username, please enter: " username
echo

while [ -z "$username" ]; do
    read -p "Username should not be empty. Please enter: " username
done

useradd $username
validate $? "User"

read -p -s "Enter password for $username: " password
echo

while [ -z "$password" ]; do
    read -p "Password should not be empty. Please enter: " password
done

echo "$password" | passwd --stdin $username
validate $? "Password"

echo "User $username created with password."

# Rest of your script...
