#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Função em assembly que interpreta as instruções
extern void interpretar_instrucoes(const char* instrucoes, int quantidade);

int main() {
    FILE *arquivo;
    char linha[10]; // Cada linha contém uma instrução hexadecimal (ex: "01A3")
    char instrucoes[100][5]; // Armazena até 100 instruções de 4 caracteres + null
    int count = 0;

    // Abre o arquivo de instruções
    arquivo = fopen("instrucoes.txt", "r");
    if (arquivo == NULL) {
        printf("Erro ao abrir o arquivo!\n");
        return 1;
    }

    // Lê cada linha do arquivo
    while (fgets(linha, sizeof(linha), arquivo) != NULL && count < 100) {
        // Remove o caractere de nova linha
        linha[strcspn(linha, "\n")] = 0;
        
        // Verifica se é uma instrução hexadecimal válida (4 caracteres)
        if (strlen(linha) == 4) {
            strcpy(instrucoes[count], linha);
            count++;
        }
    }

    fclose(arquivo);

    // Chama a função em assembly para interpretar as instruções
    for (int i = 0; i < count; i++) {
        interpretar_instrucoes(instrucoes[i], count);
    }

    return 0;
}

