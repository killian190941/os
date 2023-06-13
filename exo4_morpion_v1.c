#include <stdio.h>
#include <stdlib.h>

void init_grille(char **grille) {
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++ ) {
            grille[i][j] = ' ';
        }       
    }
}
void imprime(char **grille) {
    printf("  1   2   3  \n");
    printf("+---+---+---+\n");
    for (int i = 0; i < 3; i++) {
        printf("| %c | %c | %c | %d\n", grille[i][0], grille[i][1], grille[i][2], i + 1);
        printf("+---+---+---+\n");
    }
}

int verif_entree(int ligne, int col) {
    if (ligne < 0 || ligne > 2) {
        printf("Numéro de ligne invalide. \n");
        return 0;
    } else  if (col < 0 || col > 2) {
        printf("Numéro de colonne invalide. \n");
        return 0; 
    } else {
        return 1;
    }
}
void placement(char **grille, int col,int ligne, char joueur) {
    grille[ligne][col] = joueur;
}

int verif_grille(char **grille, int col, int ligne) {
    if (col < 0 || col > 3) {
        printf("Numero de colonne invalide. ");
        return 0; 
    } else if (ligne < 0 || ligne > 3) {
        printf("Numéro de ligne invalide. ");
        return 0;
    }  else if (grille[ligne][col] != ' ') {
        printf("La case (%d,%d) est déjà occupée. ",ligne+1,col+1);
        return 0;
    } else {
        return 1;
    }
}

char gagne(char **grille, char joueur) {
    int i;
    int j;
    //check victoire horizontale
    for (i = 0; i < 3; i++) {
        if (grille[i][0] == joueur && grille[i][1] == joueur  && grille[i][2] == joueur) { 
            return 1;
        }
    }
    //check victoire verticale
    for (j = 0; j < 3; j++) {
        if (grille[0][j] == joueur && grille[1][j] == joueur  && grille[2][j] == joueur) { 
            return 1;
        }
    }
    //check victoire diagonale 1
    if (grille[0][0] == joueur && grille [1][1] == joueur && grille [2][2] == joueur) {
        return 1;
    }
    //check victoire diagonale 2
    if (grille[0][2] == joueur && grille [1][1] == joueur && grille [2][0] == joueur) {
        return 1;
    }
    return 0;
}    

int partie_nulle(char **grille) {
    int i, j;
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            if (grille[i][j] == ' ') {
                return 0;
            }
        }
    }
    return 1;
}

int main(void) {
    // Initialisation de la grille de jeu
    char **grille = malloc(3 * sizeof(char *));
    for (int i = 0; i < 3; i++) {
        grille[i] = malloc(3 * sizeof(char));
    }
    init_grille(grille);

    imprime(grille);

    
    char joueur ='X';
    int ligne;
    int col;

    while (1) {

        printf("Joueur %c, veuillez entrer les coordonées de la ligne et de la colonne (séparées par une virgule) où vous voulez placer votre pion (de 1 à 3 pour les 2)\n",joueur);
        if (scanf("%d,%d",&ligne,&col) != 2) {
            printf("Entrée invalide. Veuillez entrer deux nombres séparés par une virgule.\n");

            // clear the buffer
            while ((getchar()) != '\n');
            continue;
        }

        col--;
        ligne--;
        
        if (!verif_entree(ligne,col)) {
            continue;
        }

        if (!verif_grille(grille,col,ligne)) {
            continue;
        }
        placement(grille,col,ligne,joueur);
        system("clear");
        imprime(grille);

        if (gagne(grille,joueur)) {
            printf("Félicitation ! le joueur %c a gagné la partie", joueur);
            break;
        }

         if (partie_nulle(grille)) {
            printf("Plus aucun coup possible, la partie se finit en match nul");
            break;
        }

        if (joueur == 'X') {
            joueur = 'O';
        } else {
            joueur = 'X';
        }
    }
    for (int i = 0; i < 3; i++) {
        free(grille[i]);
    }
    free(grille);

    return 0;
}





Game Termination
The game loop continues until a game termination condition is reached. This can be either when a player wins the game or when the game is a draw. In either case, an appropriate message is printed and the break statement is used to exit the loop:

c
Copy code
if (gagne(grille,joueur)) {
    printf("Félicitation ! le joueur %c a gagné la partie", joueur);
    break;
}

if (partie_nulle(grille)) {
    printf("Plus aucun coup possible, la partie se finit en match nul");
    break;
}
After the game loop is broken, the memory allocated for the game board is deallocated:

c
Copy code
for (int i = 0; i < 3; i++) {
    free(grille[i]);
}
free(grille);
Memory Deallocation
In C, it's important to manually deallocate any memory that was previously allocated with malloc. This prevents memory leaks, which can cause your program to use up more and more memory over time.

Here, a loop is used to deallocate each subarray of grille (each row of the game board), and then grille itself is deallocated. It's important that this is done in the correct order. If grille was deallocated first, there would be no way to access its subarrays, resulting in a memory leak.

Return Value
The last line of the main function is return 0;. In C, the main function is expected to return an integer. By convention, returning 0 indicates that the program has run successfully. Other numbers are often used to indicate specific types of errors. In this case, the program always returns 0 at the end, indicating that the game was played without any issues.


Input and Error Checking
This code uses user input to dictate game play. The scanf function is used to read input from the user:

c
Copy code
if (scanf("%d,%d",&ligne,&col) != 2) {
    printf("Entrée invalide. Veuillez entrer deux nombres séparés par une virgule.\n");

    // clear the buffer
    while ((getchar()) != '\n');
    continue;
}
Here, the program expects the user to input two integers separated by a comma. If the user does not input exactly two numbers, scanf will not return 2, the error message will be printed, and the buffer will be cleared of any remaining input before the loop continues to the next iteration.

The input values are then checked with the verif_entree and verif_grille functions to ensure they are valid moves. If the user tries to place their piece outside the bounds of the game board, or in a spot that is already taken, an error message is printed and the loop continues to the next iteration.

Game Logic
The game logic for checking if a player has won the game or if the game is a tie is encapsulated in the gagne and partie_nulle functions. The gagne function checks all possible win conditions for the current player - horizontal, vertical, and two diagonal conditions. The partie_nulle function checks if all spots on the game board have been filled, in which case the game is a tie.

Clearing the Screen
The system("clear"); command is used to clear the terminal screen. This provides a fresh view of the game board after each move, instead of appending the new game board view to the existing output.

Swapping Players
The variable joueur holds the current player's character ('X' or 'O'). After each successful move, the current player is swapped:

c
Copy code
if (joueur == 'X') {
    joueur = 'O';
} else {
    joueur = 'X';
}
These features make the game interactive and user-friendly by providing immediate and clear feedback, ensuring the game rules are followed, and presenting a fresh game board after each move.