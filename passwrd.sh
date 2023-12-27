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

useradd $username

if [ $? -eq 0 ]; then

     echo "$usernam is new user and creation done"
else
    echo "$usrname is exited already"
    exit 1
fi


