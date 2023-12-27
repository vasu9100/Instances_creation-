#!/bin/bash

ID=$(id -u)

if [ ${id} -ne 0 ]; then

    echo "Please switch to root user"
    exit 1
else

    echo "your are root user"
fi

validate() {

    if [$1 -ne 0 ]; then

        echo "$2 .....Creation falied"
        exit 1
    else
        echo "$2 ......Creation Success" 
    fi
}

echo "Adding New User"

read -p "Enter User Name :" username
echo 

while [ -z $username ]; do

    echo "username should not be empty Please enter username"
done    

useradd $username


read -p "Enter password for $username :" password

echo $password | passwd --stdin $username
validate $? "password"

