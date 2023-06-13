#include <stdio.h>
#include <stdbool.h>
#include <string.h>

char tab[3][3] = {
    {' ', ' ', ' '},
    {' ', ' ', ' '},
    {' ', ' ', ' '}
};

void imprime() {
    printf("+1-2-3+\n");
    for (int i = 0; i < 3; i++) {
        printf("%d", i+1);
        for (int j = 0; j < 3; j++) {
            printf("|%c", tab[i][j]);
        }
        printf("|\n");
    }
    printf("+1-2-3+\n");
}

bool jouer(int ligne, int colonne, char sorte) {
    if (tab[ligne][colonne] == ' ') {
        tab[ligne][colonne] = sorte;
        return true;
    } else {
        return false;
    }
}

char gagne() {
    for (int l = 0; l < 3; l++) {
        if (tab[l][0] == tab[l][1] && tab[l][0] == tab[l][2] && tab[l][0] != ' ') return tab[l][0];
    }
    for (int c = 0; c < 3; c++) {
        if (tab[0][c] == tab[1][c] && tab[0][c] == tab[2][c] && tab[0][c] != ' ') return tab[0][c];
    }
    if (tab[0][0] == tab[1][1] && tab[0][0] == tab[2][2] && tab[0][0] != ' ') return tab[0][0];
    if (tab[0][2] == tab[1][1] && tab[0][2] == tab[2][0] && tab[0][2] != ' ') return tab[0][2];

    return '\0';
}

bool egalite() {
    for (int l = 0; l < 3; l++) {
        for (int c = 0; c < 3; c++) {
            if (tab[l][c] == ' ') return false;
        }
    }
    return true;
}

int main() {
    printf("X joue\n");
    char tour = 'X';
    int ligne, colonne;
    char entree[10];

    while (1) {
        fgets(entree, sizeof(entree), stdin);
        sscanf(entree, "%d,%d", &ligne, &colonne);
        
        if (ligne >= 1 && ligne <= 3 && colonne >= 1 && colonne <= 3 && jouer(ligne - 1, colonne - 1, tour)) {
            imprime();
            if (gagne()) {
                printf("Félicitation ! le joueur %c a gagné la partie\n", tour);
                return 0;
            } else if (egalite()) {
                printf("Plus aucun coup possible, la partie se finit en match nul\n");
                return 0;
            } else {
                tour = (tour == 'X') ? 'O' : 'X';
                printf("Joueur %c, veuillez entrer les coordonées de la ligne et de la colonne (séparées par une virgule) où vous voulez placer votre pion (de 1 à 3 pour les 2)\n", tour);
            }
        } else {
            printf("invalide try again\n");
        }
    }
}
   

