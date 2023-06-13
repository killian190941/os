#include <stdio.h>
#include <stdlib.h>

char grille[6][7];

void init_grille(){
    for (int i=0; i<6; i++){
        for (int j=0; j<7; j++){
            grille[i][j]=' ';
        }
    }
}

void print_grille(){
    printf(" 1 | 2 | 3 | 4 | 5 | 6 | 7 \n");
    printf("---+---+---+---+---+---+---+\n");
    for (int i=0; i<6; i++){
        for (int j=0; j<7; j++){
            printf(" %c |", grille[i][j]);
        }
        printf("\n");
        printf("---+---+---+---+---+---+---+\n");
    }
}



int verif_col(int col) {
    if (col < 0 || col > 6) {
        printf("Numero de colonne invalide. ");
        return 0; 
    } else if (grille[0][col]!=' ') {
        printf("Cette colonne est remplie, veuillez en choisir une autre.\n");
        return 0;
    } else {
        return 1;
    }
}

void placer_jeton(int col, char joueur) {
    int ligne = 5;
    while (grille[ligne][col] != ' ') {
        ligne--;
    }
    grille[ligne][col] = joueur;
}

int check_victoire (char joueur) {
    int i;
    int j;

    //check victoire horizontale
    for (i = 5; i >= 0; i--) {
        for (j = 0; j < 4; j++) {
            if (grille[i][j] == joueur && grille[i][j + 1] == joueur && grille[i][j + 2] == joueur && grille[i][j + 3] == joueur) {
                return 1;
            }
        }
    }
    //check victoire verticale
    for (j = 0; j < 7; j++) {
        for (i = 5; i > 2; i--) {
            if (grille[i][j] == joueur && grille[i - 1][j] == joueur && grille[i - 2][j] == joueur && grille[i - 3][j] == joueur) {
                return 1;
            }
        }
    }

    //Check victoire diagonale montante
    for (j = 0; j < 4; j++) {
        for (i = 5; i > 2; i--) {
            if (grille[i][j] == joueur && grille[i - 1][j +1] == joueur && grille[i - 2][j + 2] == joueur && grille[i - 3][j + 3] == joueur) {
                return 1;
            }
        }
    }
    //check victoire diagonale descendante
    for (j = 0; j < 4; j++) {
        for (i = 2; i >= 0; i--) {
            if (grille[i][j] == joueur && grille[i + 1][j + 1] == joueur && grille[i + 2][j + 2] == joueur && grille[i + 3][j + 3] == joueur) {
                return 1;
            }
        }
    }
    //si aucun joueur a gagné, la fonction return 0
    return 0;
}


int partie_nulle() {
    int i, j;
    for (i = 0; i < 6; i++) {
        for (j = 0; j < 7; j++) {
            if (grille[i][j] == ' ') {
                return 0;
            }
        }
    }
    return 1;
}


int main(void) {
    // Initialisation de la grille de jeu
    init_grille();

    // appel de la fonction qui imprime la grille de jeu
    print_grille();

    //début du jeu
    char joueur = 'X';
    int col;
    int n = 0;
    while (n == 0) {
        printf("Joueur %c, veuillez entrer le numéro de la colonne où placer le jeton (de 1 à 7).\n",joueur);
        scanf("%d",&col);

        //on diminue la valeure de col de 1 pour être raccord avec les valeurs de la fonction (dont l'indice de la première colonne vaut 0)
        col--;

        //On appelle la fonction qui va vérifier que le numéro de la colonne entrée est bien compris entre 1 et 7 et qu'elle n'est pas pleine
        if (!verif_col(col)) {
            continue;
        }
        
        //On apelle les fonctions qui 1. inscrit le coup sur la grille et 2. qui imprime la grille modifiée après le coup.
        //Juste avant d'imprimer la nouvelle grille, on va clear le terminal pour pas avoir toutes les grilles qui s'enchainent sur le terminal
        placer_jeton(col,joueur);
        system("clear");
        print_grille();

        //si la fonction return 1, alors la valeur de n change et on sort de la boucle while
        if (check_victoire(joueur)) {
            printf("Félicitation ! le joueur %c a gagné la partie !", joueur);
            break;
        }
        if (partie_nulle()) {
            printf("Plus aucun coup possible, la partie finit en match nul");
            break;
        }
        //si la partie n'est pas finie, c'est au tour du joueur suivant et on répète la boucle
        if (joueur == 'X') {
            joueur = 'O';
        } else {
            joueur = 'X';
        }
        
    }

    return 0;
    
}    
