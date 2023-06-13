#!/bin/bash

# Avant de pouvoir utiliser la commande "backup" pour la première fois, il est nécessaire d'exécuter :

# Donner les droits d'execution à l'utilisateur et envoyer ce script vers ~/bin
# chmod +x backup.sh
# mv backup.sh ~/bin/backup

# Mettre ~/bin dans le PATH environment propre au user
# nano ~/.bashrc
# A la fin de ~/.bashrc rajouter:
# export PATH=$PATH:~/bin
# Appliquer les changements
# source ~/.bashrc

# Valider le paramètre
if [ "$#" -ne 1 ]; then
    echo "Il faut entrer un seul argument"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Erreur : $1 n'est pas un répertoire"
    exit 1
fi  
dir_realpath=$(realpath -m "$1")
home_realpath=$(realpath -m "$HOME")

if [[ ! "$dir_realpath" == "$home_realpath"* ]]; then
    echo "Erreur: l'argument doit être un sous repertoire de home"
    exit 1
fi

# Créer le répertoire de sauvegarde
backup_name=$(date +"%Y%m%d%H%M%S")
backup_dir="$HOME/.backup/$backup_name"
mkdir -p "$backup_dir"

# Copier les fichiers en conservant les liens symboliques et en restreignant les droits
cp -rp --preserve=links "$1" "$backup_dir"

# Restreindre les droits des fichiers copiés
find "$backup_dir" -type f -exec chmod u=r,go= {} \;

echo "Backup created at: $backup_dir"



#!/bin/bash

# Before using the "backup" command for the first time, it's necessary to execute the following steps:

# Give execution rights to the user and send this script to ~/bin
# chmod +x backup.sh
# mv backup.sh ~/bin/backup

# Put ~/bin in the user's PATH environment variable
# nano ~/.bashrc
# At the end of ~/.bashrc add:
# export PATH=$PATH:~/bin
# Apply changes with
# source ~/.bashrc

# Validate the parameter
# Check if exactly one argument is passed
# If not, print an error message and exit the script
if [ "$#" -ne 1 ]; then
    echo "Il faut entrer un seul argument"
    exit 1
fi

# Check if the provided argument is a directory
# If not, print an error message and exit the script
if [ ! -d "$1" ]; then
    echo "Erreur : $1 n'est pas un répertoire"
    exit 1
fi

# Get the real path of the directory to be backed up and the home directory
dir_realpath=$(realpath -m "$1")
home_realpath=$(realpath -m "$HOME")

# Check if the directory to be backed up is a subdirectory of the home directory
# If not, print an error message and exit the script
if [[ ! "$dir_realpath" == "$home_realpath"* ]]; then
    echo "Erreur: l'argument doit être un sous repertoire de home"
    exit 1
fi

# Create the backup directory
# The backup directory's name is the current date and time
backup_name=$(date +"%Y%m%d%H%M%S")
backup_dir="$HOME/.backup/$backup_name"

# The -p option makes mkdir create the directory, and its parents if they do not exist
mkdir -p "$backup_dir"

# Copy files while preserving symbolic links and restricting rights
cp -rp --preserve=links "$1" "$backup_dir"

# Restrict the rights of copied files
# The find command is used to find all files in the backup directory
# The -exec option allows for another command (chmod) to be run on each file
# The chmod command changes the permissions of each file to be readable by the user, and not accessible by the group or others
find "$backup_dir" -type f -exec chmod u=r,go= {} \;

# Print the location of the created backup
echo "Backup created at: $backup_dir"



#!/bin/bash

# Avant de pouvoir utiliser la commande "backup" pour la première fois, il est nécessaire d'exécuter :

# Donner les droits d'execution à l'utilisateur et envoyer ce script vers ~/bin
# chmod +x backup.sh
# mv backup.sh ~/bin/backup

# Mettre ~/bin dans le PATH environment propre au user
# nano ~/.bashrc
# A la fin de ~/.bashrc rajouter:
# export PATH=$PATH:~/bin
# Appliquer les changements
# source ~/.bashrc

# Valider le paramètre
if [ "$#" -ne 1 ]; then
    echo "Il faut entrer un seul argument" >&2
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Erreur : $1 n'est pas un répertoire" >&2
    exit 1
fi  
dir_realpath=$(realpath -m "$1")
home_realpath=$(realpath -m "$HOME")

if [[ ! "$dir_realpath" == "$home_realpath"* ]]; then
    echo "Erreur: l'argument doit être un sous repertoire de home"
    exit 1
fi

# Créer le répertoire de sauvegarde
backup_name=$(date +"%Y%m%d%H%M%S")
backup_dir="$HOME/.backup/$backup_name"
mkdir -p "$backup_dir"

# Copier les fichiers en conservant les liens symboliques et en restreignant les droits
cp -rp --preserve=links "$1" "$backup_dir"

# Restreindre les droits des fichiers copiés
find "$backup_dir" -type f -exec chmod u=r,go= {} \;

echo "Backup created at: $backup_dir"

Voici l'énoncé :

Un backup consistera en la sauvegarde d’une arborescence spécifiée :
backup ~/fiche4
Cette arborescence doit appartenir au home directory de l’utilisateur qui exécute la 
commande backup. On ne pourra ainsi pas faire backup / par exemple.
Les fichiers de l’arborescence seront copiés dans un sous-répertoire caché du home directory 
appelé ~/.backup/AAAAMMJJHHmmss
Où AAAAMMJJHHmmss est la concaténation de l’année, du mois, du jour, de l’heure, de la 
minute et de la seconde où a été exécuté la commande. Cette date permet d’avoir plusieurs 
backups des mêmes fichiers pris à des moments différents. Dans ce répertoire se trouve une 
structure de répertoires qui reproduit l’arborescence du home directory de l’utilisateur 
restreinte au répertoire à backuper.
Ainsi, si mon arborescence est comme ceci :
~/fiche4/reponse.txt
~/fiche4/script/monScript.sh
La commande backup ~/fiche4 résultera en :
~/.backup/20230318121031/fiche4/reponse.txt
~/.backup/20230318121031/fiche4/script/monScript.sh
La commande :
cd ~/fiche4/script ; backup .
Résultera en :
~/.backup/20230318121412/fiche4/script/monScript.sh
De plus, les fichiers copiés dans le backup auront des droits restreints : seul l’auteur du 
backup pourra le lire.
Indices :
1. Validez le paramètre avant de faire quoique ce soit :
a. Il doit y en avoir un seul.
b. Il doit être un répertoire : confer commande test
c. Il doit être un sous-répertoire du home directory. La commande 
realpath -m path
renvoie le chemin absolu du path donné en paramètre. Ce chemin absolu 
doit commencer par $HOME ; egrep peut aider à le détecter.
2. Le nom du sous-répertoire de ~/.backup peut être obtenu par la commande date.
3. La commande cp peut effectuer une copie récursive si on lui demande, mais il faudra 
faire attention à reproduire l’arborescence correcte dans le répertoire de backup : 
a. Travailler avec des répertoires absolus rend cela plus simple : commande 
realpath
b. ${#HOME} : la longueur de la chaîne contenue dans $HOME
c. cut -c : supprime des caractères
2023
d. mkdir -p rep : crée le répertoire rep et tous les répertoires 
intermédiaires manquants
4. Attention à traiter les liens symboliques correctement ; il faut les recopier tels quels 
et pas recopier leur contenu. Une option de cp est capable de le faire.
5. Attention aux droits des fichiers copiés : les backups sont uniquement accessibles en 
lecture au propriétaire.

Est ce que le code garantie que cela marche ?

La commande :
cd ~/fiche4/script ; backup .
Résultera en :
~/.backup/20230318121412/fiche4/script/monScript.sh

ChatGPT
Oui, le script semble respecter les critères donnés dans l'énoncé. Il effectue un contrôle d'erreur pour vérifier qu'un seul argument est donné, que l'argument est un répertoire, et que le répertoire est un sous-répertoire du répertoire home de l'utilisateur.

Le script crée ensuite un nouveau répertoire de sauvegarde avec un nom basé sur l'horodatage actuel. Il utilise la commande cp -rp --preserve=links pour effectuer une copie récursive de l'arborescence spécifiée, en conservant les liens symboliques. Les fichiers dans le répertoire de sauvegarde ont leurs permissions modifiées pour être en lecture seule pour l'utilisateur.

Le script utilise realpath -m pour obtenir le chemin absolu du répertoire à sauvegarder et du répertoire home de l'utilisateur. Il vérifie alors que le chemin absolu du répertoire à sauvegarder commence par le chemin absolu du répertoire home.

Pour l'exemple fourni :

cd ~/fiche4/script ; backup .

Cela devrait fonctionner comme prévu. Le chemin du répertoire actuel (.) est un sous-répertoire de $HOME, donc le script de sauvegarde copiera le contenu de ~/fiche4/script dans un nouveau sous-répertoire de ~/.backup/, avec le sous-répertoire nommé selon l'horodatage actuel.

Dans l'ensemble, ce script devrait fonctionner comme une solution de sauvegarde efficace pour les arborescences de répertoires spécifiées dans le répertoire home de l'utilisateur, en respectant les critères donnés dans l'énoncé.