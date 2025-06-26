#include <stdio.h>
#include <stdlib.h>

// Declara a função assembly
extern void executar_instrucao(int instrucao);

// Lê instruções de um arquivo HEX e envia para o interpretador
int main() {
    FILE* arquivo = fopen("instrucoes.txt", "r"); // Abre o arquivo .txt
    if (!arquivo) {
        perror("Erro ao abrir o arquivo");
        return 1;
    }

    char linha[10];
    while (fgets(linha, sizeof(linha), arquivo)) {
        int instrucao = (int)strtol(linha, NULL, 16); // converte a string para um numero inteiro
        executar_instrucao(instrucao); // passa a instrucao convertida
    }

    fclose(arquivo); // fecha o arquivo .txt
    return 0;
}

// nasm -f elf32 core.asm -o cpu.o
// gcc -m32 main.c cpu.o -o sim
// ./sim
