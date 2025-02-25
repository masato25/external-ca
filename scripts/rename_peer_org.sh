#!/bin/bash

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

CURRENTORGDOMAIN=org1.example.com
CURRENTORGMSPNAME=Org1

REPLACEORGDOMAIN=org1.example.com
REPLACEORGMSPNAME=Org1

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
