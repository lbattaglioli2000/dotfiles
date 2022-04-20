#!/bin/sh

echo "Cloning repositories..."

SITES=$HOME/Sites
BLADE=$SITES/blade-ui-kit
LARAVEL=$SITES/laravel
APPS=$HOME/Apps
APIS=$HOME/APIs

# Personal
git clone git@github.com:lbattaglioli2000/theluigi.com.git $LARAVEL/theluigi.com
git clone git@github.com:lbattaglioli2000/abacus.git $LARAVEL/abacus

# Eorbi
git clone git@github.com:Eorbi/eorbi-jetstream-livewire.git $LARAVEL/eorbi
git clone git@github.com:Eorbi/text-story-node-js-api.git $APIS/starcade
git clone git@github.com:Eorbi/eorbi-mobile-app.git $APPS/eorbi
