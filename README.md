CRDPPF Portal
============

Repértoire privé

    cd

Répertoire instance principale
    
    cd /var/www/vhosts/sitj/private
  
Téléchargé le projet  GitHub

    git clone git@github.com:SIT-Jura/crdppf.git
    cd crdppf

Télécharger crdppf_core

    git clone git@github.com:sitn/crdppf_core.git
    cd crdppf_core
    git checkout py3
    git submodule update --init
    cd ..

After the installation put the directoriy crdpp in W

    chmod -R o+w .

Build

    make -f <user>.mk build

Run

    docker-compose up -d

Logs

    docker-compose logs -f --tail=0 geoportal

Stop

    docker-compose down

# Upgrade and update crdppf_core

To upgrade crdppf_core version of the project go into the crdppf_core folder of your project
Make sure your on the master branch or the branch you want to be on:

to get the list of your local branches:
    git branch

change on master if needed:   
 
    git checkout master

or create a new branch of your choice if you don't want to overwrite the master:

    git checkout -b [mynewbranch]
    
Update and upgrade:

    cd crdppf_core
    git fetch
    git checkout <tag>
    git submodule sync
    git submodule update --init

<tag> is the version of crdppf_core (ex: 1.0.7) 
     
