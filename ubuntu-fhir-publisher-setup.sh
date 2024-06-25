#!/bin/bash

echo "-----updating package tool"
sudo apt update -y 

echo "-----Installing java and the prerequisites for jekyll (ruby-full build-essential zlib1g-dev)"
sudo apt install -y openjdk-21-jdk ruby-full build-essential zlib1g-dev graphviz

echo "-----Setting environment variables to bash configuration file"
export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
echo 'export JAVA_HOME="'$JAVA_HOME'"' >> ~/.bashrc

echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc

echo "-----reload bash configuration file"
source ~/.bashrc

# echo "-----Installing fonts for Java FHIR-publisher"
# sudo apt-get -y install libfreetype6 fontconfig

echo "-----Installing npm & sushi"
if ! (which sushi > 0) ; then
   curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
   sudo apt-get install -y nodejs
   sudo npm install -g npm@latest 
   sudo npm install -g fsh-sushi
fi


echo "-----Installing Jekyll"
if ! (which jekyll > 0) ; then
   sudo gem install jekyll bundler
fi

echo "-----Downloading Java FHIR-publisher"
PUBLISHERPATH=input-cache

echo "-----making a fhir-publisher-directory in the user-home"
mkdir -p $PUBLISHERPATH
wget  -P $PUBLISHERPATH "https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar"



echo -n "Do you want to install Firely Terminal (in order to use structure definitions in Simplifier): y/n"
   read -r installFirelyTerminal
   
echo "-----Installing Firely Terminal"
if installFirelyTerminal = "y" ; then
  sudo apt install -y dotnet-sdk-6.0
  echo 'export PATH=$PATH:~/.dotnet/tools' >> ~/.bashrc
  echo "-----reload bash configuration file"
  source ~/.bashrc
  if ! (which fhir > 0) ; then
    dotnet tool install -g firely.terminal
   
    echo "-----Optional: you can install (create snapshots of) Simplifier structure definitions with e.g. command: fhir install nictiz.fhir.nl.r4.nl-core 0.10.0-beta.1"
  fi
fi

echo "-----Optional: Configure WSL to use the Windows credential helper:  git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe""

echo "-----Configure GIT"
echo -n "Do you want to configure git user.name and user.mail? : y/n"
   read -r configureGitGlobals

if configureGitGlobals = "y" ; then
   echo "-----Please set git credentials"

   echo -n "Your name: "
   read -r name

   echo -n "Your email adress: "
   read -r email

   git config --global user.name $name
   git config --global user.email $email
fi

echo -n "Do you want to clone a github-repository in current directory? : y/n"
   read -r cloneRepository

if configureGitGlobals = "y" ; then
   echo -n "Please provide the url of the github-repository:"
   read -r repositoryUrl
   
   echo "-----Cloning git repo"
   git clone $repositoryUrl
fi

echo "-----Example FHIR Publisher command: java -jar './input-cache/publisher.jar' -ig ."
echo "it assumes you have an ig.ini file in your repository. More information on the publisher and this .ini file: https://confluence.hl7.org/pages/viewpage.action?pageId=175618322"