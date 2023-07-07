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
    
    echo "enable xhost for GUI applications? y/n"
    read enable_xhost
    while [ $enable_xhost -ne 'n' || $enable_xhost -ne 'n']
    do
        echo "enable xhost for GUI applications? y/n"
        read enable_xhost
    done

    if [ $enable_xhost -eq "y" ]
    then
        xhost +local:root # dangerous line I know but this isn't prod :P 
    else
        echo "GUI apps disabled(may run into errors!)"
    fi
else
    echo "env already exists!"
    
fi