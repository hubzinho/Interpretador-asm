# Interpretador-asm

**Projeto para Arquitetura de Computadores** que lê intruções em hex e converte para código de máquina.

## Como usar
# Compilar (Linux):

```bash
nasm -f elf32 src/interpretador.asm -o interpretador.o
gcc -m32 src/main.c interpretador.o -o interpretador
```
