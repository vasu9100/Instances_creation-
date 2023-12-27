#!/bin/bash

ID=$(id -u)

if [ ${id} -ne 0 ]; then

    echo "Please switch to root user"
    exit 1
else

    echo "your are root user"
fi

validate() {

    if [ $1 -ne 0 ]; then

        echo "$2 .....Creation falied"
        exit 1
    else
        echo "$2 ......Creation Success" 
    fi
}

echo "Adding New User"

read -p "username Please Enter :" username
echo 

while [ -z $username ]; do

    read -p "username should not be empty Please Enter :" username 
    break
done    

useradd $username
validate $? "user"


read -p "Enter password for $username :" password

while [ -z $password ]; do

    read -p -s "password should not be empty Please Enter :" password 
    break
    exit 1
done    

echo $password | passwd --stdin $username
validate $? "password"

