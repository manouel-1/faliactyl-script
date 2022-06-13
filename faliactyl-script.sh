#!/bin/bash

set -e
   clear
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "You are using faliactyl Script Version 1.0"
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "You can Report Bug on GitHub, or on our Discord"
    echo "You can get more info on our Discord"
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "© Copyright 2022 / Script Maded by Hyricon Deveploment Team."
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"


install_options(){
    echo "Please select your installation option:"
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "(1) Install Full Faliactyl"
    echo "(2) Install The dependencies"
    echo "(3) Install The Files"
    echo "(4) Uninstall Faliactyl"
    echo "(5) Exit"
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    read -r choice
    case $choice in
        1 ) installoption=1
            dependercy_install
            file_install
            settings_configuration
            reverseproxy_configuration
            ;;
        2 ) installoption=2
            dependercy_install
            ;;
        3 ) installoption=3
            file_install
            ;;
        4 ) installoption=4
            remove
            ;;
        5 ) installoption=5
            cancel
            ;;
         
        * ) output "You did not enter a valid selection."
            install_options
    esac
}

dependercy_install() {
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "Starting Dependercy install, Only wait"
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    curl -fsSL https://deb.nodesource.com/setup_14.x | sudo bash -
    sudo apt install nodejs
    sudo apt install npm
    sudo apt-get install git
    sudo apt update
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "Done!"
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
}
file_install() {
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "Starting File install."
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    mkdir /var/www -p
    cd /var/www/
    sudo git clone https://github.com/Hyricon-Development/Faliactyl.git
    cd Faliactyl
    sudo npm install
    sudo npm install pm2 -g
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "Done!"
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
}
settings_configuration() {
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "Starting Settings Configuration."
    echo "Go to Faliactyl docs for more information about the settings."
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    cd /var/www/Faliactyl/
    file=settings.json
    echo "What is the web port? [8080] (This is the port Faliactyl will run on)"
    read -r WEBPORT
    echo "What is the web secret? (This will be used for logins)"
    read -r WEB_SECRET
    echo "What is the pterodactyl domain? [panel.yourdomain.com]"
    read -r PTERODACTYL_DOMAIN
    echo "What is the pterodactyl key?"
    read -r PTERODACTYL_KEY
    echo "What is the Discord Oauth2 ID?"
    read -r DOAUTH_ID
    echo "What is the Discord Oauth2 Secret?"
    read -r DOAUTH_SECRET
    echo "What is the Discord Oauth2 Link?"
    read -r DOAUTH_LINK
    echo "What is the Callback path? [callback]" 
    read -r DOAUTH_CALLBACKPATH
    echo "Prompt [TRUE/FALSE] (When set to true users wont have to relogin after a session)"
    read -r DOAUTH_PROMPT
    sed -i -esed -i -e 's/"port":.*/"port": '"$WEBPORT"',/' -e 's/"secret":.*/"secret": "'"$WEB_SECRET"'"/' -e 's/"domain":.*/"domain": "'"$PTERODACTYL_DOMAIN"'",/' -e 's/"key":.*/"key": "'"$PTERODACTYL_KEY"'"/' -e 's/"id":.*/"id": "'"$DOAUTH_ID"'",/' -e 's/"link":.*/"link": "'"$DOAUTH_LINK"'",/' -e 's/"path":.*/"path": "'"$DOAUTH_CALLBACKPATH"'",/' -e 's/"prompt":.*/"prompt": '"$DOAUTH_PROMPT"'/' -e '0,/"secret":.*/! {0,/"secret":.*/ s/"secret":.*/"secret": "'"$DOAUTH_SECRET"'",/}' $file 's/"port":.*/"port": '"$WEBPORT"',/' -e 's/"secret":.*/"secret": "'"$WEB_SECRET"'"/' -e 's/"domain":.*/"domain": "'"$PTERODACTYL_DOMAIN"'",/' -e 's/"key":.*/"key": "'"$PTERODACTYL_KEY"'"/' -e 's/"id":.*/"id": "'"$DOAUTH_ID"'",/' -e 's/"link":.*/"link": "'"$DOAUTH_LINK"'",/' -e 's/"path":.*/"path": "'"$DOAUTH_CALLBACKPATH"'",/' -e 's/"prompt":.*/"prompt": '"$DOAUTH_PROMPT"'/' -e '0,/"secret":.*/! {0,/"secret":.*/ s/"secret":.*/"secret": "'"$DOAUTH_SECRET"'",/}' $file    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "Configuration Settings Completed!"
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
}
reverseproxy_configuration() {
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "Starting Reverse Proxy Configuration."
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"

   echo "Select your webserver [NGINX]"
   read WEBSERVER
   echo "Protocol Type [HTTP]"
   read PROTOCOL
      if [ "$PROTOCOL" != "HTTP" ]; then
   echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
   echo "HTTP is currently only supported on the install script."
   echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
   return
   fi
   if [ "$WEBSERVER" != "NGINX" ]; then
   echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
   echo "Aborted, only Nginx is currently supported for the reverse proxy."
   echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
   return
   fi
   echo "What is your domain? [example.com]"
   read DOMAIN
   apt install nginx
   sudo apt install certbot
   sudo apt install -y python3-certbot-nginx
   sudo wget -O /etc/nginx/conf.d/faliactyl.conf 
   sudo apt-get install jq 
   PORT=$(jq -r '.["website"]["port"]' /var/www/Faliactyl/settings.json)
   sed -i 's/PORT/'"$PORT"'/g' /etc/nginx/conf.d/faliactyl.conf
   sed -i 's/DOMAIN/'"$DOMAIN"'/g' /etc/nginx/conf.d/faliactyl.conf
   sudo nginx -t
   sudo nginx -s reload
   systemctl restart nginx
   echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
   echo "Reverse Proxy Install and configuration Done."
   echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
   echo "Here is the config status:"
   sudo nginx -t
   echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
   echo "Note: if it does not say OK in the line, an error has occurred and you should try again or get help in the faliactyl Discord Server."
   echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
   if [ "$WEBSERVER" = "APACHE" ]; then
   echo "Apache isn't currently supported with the install script."
   echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
   return
   fi
}
remove() {
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "Removing please wait"
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    cd /var/www/
    rm -r Faliactyl
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "finished"
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
}
cancel() {
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    echo "Closing Script, Please Wait"
    echo "══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"
    sudo kill
}

install_options
