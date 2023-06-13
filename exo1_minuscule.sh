#!/bin/bash

function maj2min() {
    # Vérification du nombre d'arguments passés
    if [ $# -gt 1 ]; then
        echo "Erreur : Nombre incorrect d'arguments passés." >&2
        echo "Usage: $0 [répertoire]" >&2
        exit 1
    fi

    # Récupération du répertoire racine
    if [ $# -eq 1 ]; then
        root_dir="$1"
    else
        root_dir="$(pwd)"
    fi

    # Vérification de l'existence du répertoire racine
    if [ ! -d "$root_dir" ]; then
        echo "Erreur : Le répertoire spécifié n'existe pas." >&2
        exit 1
    fi

    # Récupération de la liste des fichiers dans l'arborescence
    list_fichier=$(find "$root_dir" -type f -o -type -d)
    liste_fichier=$(echo "list_fichier" sort -)

    # Boucle sur chaque fichier
    for fichier in $list_fichier; do
        nom_fichier=$(basename "$fichier")
        nom_fichier_minuscule=$(echo "$nom_fichier" | tr '[:upper:]' '[:lower:]')
        destination=$(dirname "$fichier")/"$nom_fichier_minuscule"

        # Vérification du renommage nécessaire
        if [ "$fichier" != "$destination" ]; then
            # Renommage du fichier
            mv "$fichier" "$destination" >/dev/null 2>&1

            # Vérification du succès du renommage
            if [ $? -ne 0 ]; then
                echo "Erreur lors du renommage du fichier : $fichier" >&2
            fi
        fi
    done
}

# Appeler la fonction avec les arguments passés au script
maj2min "$@"


#!/bin/bash

# Defining the function that will convert all the file names from uppercase to lowercase in the specified directory
function maj2min() {
    # Checking if the number of arguments passed is more than 1. 
    # If so, this indicates incorrect usage of the function, so the error is printed and the script exits with a failure status.
    if [ $# -gt 1 ]; then
        echo "Erreur : Nombre incorrect d'arguments passés." >&2
        echo "Usage: $0 [répertoire]" >&2
        exit 1
    fi

    # If a directory argument is provided, then that's set as the root directory. 
    # Otherwise, the current working directory (where the script is run from) is used as the root directory.
    if [ $# -eq 1 ]; then
        root_dir="$1"
    else
        root_dir="$(pwd)"
    fi

    # Checking if the specified root directory exists. 
    # If not, an error message is printed and the script exits with a failure status.
    if [ ! -d "$root_dir" ]; then
        echo "Erreur : Le répertoire spécifié n'existe pas." >&2
        exit 1
    fi

    # Getting a list of all the files under the root directory. 
    # The 'find' command is used with the '-type f' flag to only consider files (and not directories).
    list_fichier=$(find "$root_dir" -type f)

    # For each file in the list of files
    for fichier in $list_fichier; do
        # Extract the base name of the file
        nom_fichier=$(basename "$fichier")
        # Convert the base name to lowercase
        nom_fichier_minuscule=$(echo "$nom_fichier" | tr '[:upper:]' '[:lower:]')
        # Construct the destination file path
        destination=$(dirname "$fichier")/"$nom_fichier_minuscule"

        # Check if the original file path and the destination file path are not the same 
        # (indicating that the file name has uppercase characters that need to be converted to lowercase)
        if [ "$fichier" != "$destination" ]; then
            # Renaming the file. The stdout and stderr are redirected to /dev/null to suppress any output.
            mv "$fichier" "$destination" >/dev/null 2>&1

            # Checking the exit status of the 'mv' command. 
            # If it's not zero, then an error occurred during the renaming of the file, 
            # so an error message is printed.
            if [ $? -ne 0 ]; then
                echo "Erreur lors du renommage du fichier : $fichier" >&2
            fi
        fi
    done
}

# Calling the defined function with all the arguments passed to the script. 
# This means that when the script is run, it will pass any arguments it received to the 'maj2min' function.
maj2min "$@"


const int TAILLE=10; ->  Par convention, les constantes sont mises en majuscules.


MODIFICATION CODES OS:

EXO1:

Si prof demande de mettre aussi en minuscule les répertoires (exo1_fd.sh):

Ligne 25 -> 28:

# Get the list of all files and directories in the tree
list_fichier=$(find "$root_dir" -type f -o -type d)

# Sort the list in reverse order to handle subdirectories before their parents
list_fichier=$(echo "$list_fichier" | sort -r)

EXO2:
