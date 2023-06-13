#!/bin/bash

# Check if the user entered exactly 4 parameters in the terminal
# If the user didn't enter 4 parameters, display an error message and exit the script
if [ $# -ne 4 ]; then
    echo "Veuillez entrer 4 arguments" 2>/dev/null
    exit 1
fi

# Make sure the 3rd and 4th parameters are positive integers
# If the 3rd or 4th parameters aren't positive integers, display an error message and exit the script
if ! [[ "$3" =~ ^[1-9][0-9]+$ ]] || ! [[ "$4" =~ ^[1-9][0-9]+$ ]]; then 
    echo "Les 3 et 4ème paramètres doivent être des entiers positifs différents de 0" 2>/dev/null
    exit 1
fi

# Store the 1st parameter (source directory) in variable rep_src
rep_src=$1
# Store the 2nd parameter (destination directory) in variable rep_cop
rep_cop=$2
# Store the 3rd parameter in variable X
X=$3
# Store the 4th parameter in variable Y
Y=$4

# Check if the source directory exists AND is a directory
# If the source directory doesn't exist or isn't a directory, display an error message and exit the script
if ! [ -d "$rep_src" ]; then
    echo "Le répertoire source n'existe pas ou n'est pas un répertoire" 2>/dev/null
    exit 1
fi

# If the destination directory doesn't exist, then create it
if ! [ -d "$rep_cop" ]; then
    mkdir "$rep_cop"
fi

# Start an infinite loop
while true; do

    # Print a message to indicate the copy operation has started
    echo "copie du répertoire en cours..." 2>/dev/null

    # Perform a recursive copy of the source directory to the destination directory, and run this copy operation in the background
    cp -r "$rep_src" "$rep_cop" &

    # Get the PID of the last process launched in the background (i.e., the copy operation), and save it in variable cp_PID
    cp_PID=$!

    # Wait for X seconds
    sleep "$X"

    # If the copy operation isn't finished after X seconds, pause it
    # If the copy operation is already finished, exit the loop
    if kill -SIGSTOP "$cp_PID" 2>/dev/null; then
        # Print a message to indicate the copy operation has been paused
        echo "Attente que le disque refroidisse avant de reprendre la copie." 2>/dev/null

        # Wait for Y seconds
        sleep "$Y"

        # Resume the copy operation
        kill -SIGCONT "$cp_PID" 2>/dev/null
        # Print a message to indicate the copy operation has resumed
        echo "Reprise de la copie..."

        # Wait for the copy operation to finish
        wait "$cp_PID"
        # Print a message to indicate the copy operation has finished
        echo "Copie terminée"
        break
    else
        # Print a message to indicate the copy operation has finished
        echo "Copie terminée"
        break
    fi
done

# Exit the script with a success status
exit 0


Le while loop était mauvais:


# IL FAUT SORTIR LES TROIS PROCHAINES LIGNES DE LA BOUCLE while
echo "copie du répertoire en cours..." 2>/dev/null

#copie récursive du répertoire source vers le répertoire destination, la copie se fait en arrière plan grâce à la commande &
cp -r "$rep_src" "$rep_cop" &

#$! permet d'avoir le PID du dernier processus lancé en arrière-plan, qu'on sauvegarde dans la variable cp_PID
cp_PID=$!

while true; do
    # Attente de X secondes
    sleep "$X"

    # Suspension du processus de copie si elle n'est pas terminée après X secondes. Si elle est terminée on sort de la boucle.
    if kill -SIGSTOP "$cp_PID" 2>/dev/null; then
        echo "Attente que le disque refroidisse avant de reprendre la copie." 2>/dev/null

        # Attente de Y secondes
        sleep "$Y"

        # Reprise de la copie
        kill -SIGCONT "$cp_PID" 2>/dev/null
        echo "Reprise de la copie..."

        # ICI IL FAUT ENLEVER LE break CAR SINON LA BOUCLE while N'A AUCUN SENS D'EXISTER
    else
        echo "Copie terminée"
        break
    fi
done
exit 0
