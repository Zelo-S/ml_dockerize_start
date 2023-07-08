#!/bin/bash

origin=$PWD
docker_file="$origin/docker-compose.yml"
echo "enter project name:"
read directory_name
cd ..

if [ ! -d "$PWD/$directory_name" ]; 
then
    echo -e 
    echo "creating $directory_name..."
    mkdir $directory_name
    cd $directory_name
    
    cp -p $docker_file .


    name="$( basename $PWD | tr '[:upper:]' '[:lower:]')"
    mkdir data/
    touch .gitignore # might be helpful

    docker compose -p $name up -d
    echo -e 
    docker ps
    
    echo ""
    while true; do

    read -p "enable xhost for GUI applications? [y]/n" yn

    case $yn in 
        y ) echo proceeding
            xhost +local:root
            break;;
        n ) echo exiting...;
            exit;;
        * ) echo proceeding
            xhost +local:root
            break;;
    esac

    done
else
    echo "env already exists!"
    
fi