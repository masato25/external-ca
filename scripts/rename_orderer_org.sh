#!/bin/bash

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

CURRENTORGDOMAIN=orderer.example.com
CURRENTORGMSPNAME=Orderer

REPLACEORGDOMAIN=orderer.example.com
REPLACEORGMSPNAME=Orderer

echo "Current os: $machine"
if [ $machine = "Linux" ]
then
  find ./ ! -iname 'rename*.sh' -type f \( -iname \*.yaml -o -iname \*.sh -o -iname \*.cnf -o -iname \*.md \) -exec sed -i "s/$CURRENTORGDOMAIN/$REPLACEORGDOMAIN/g" {} \;
  find ./ ! -iname 'rename*.sh' -type f \( -iname \*.yaml -o -iname \*.sh -o -iname \*.cnf -o -iname \*.md \) -exec sed -i "s/$CURRENTORGMSPNAME/$REPLACEORGMSPNAME/g" {} \;
elif [ $machine = "Mac" ]
then
  find ./ ! -iname 'rename*.sh' -type f \( -iname \*.yaml -o -iname \*.sh -o -iname \*.cnf -o -iname \*.md \) -exec sed -i '' -e "s/$CURRENTORGDOMAIN/$REPLACEORGDOMAIN/g" {} \;
  find ./ ! -iname 'rename*.sh' -type f \( -iname \*.yaml -o -iname \*.sh -o -iname \*.cnf -o -iname \*.md \) -exec sed -i '' -e "s/$CURRENTORGMSPNAME/$REPLACEORGMSPNAME/g" {} \;
else
  echo "$machine is unsupported!"
fi
