# Simulador de Processador Hipotético

**Projeto para Arquitetura de Computadores**
Este projeto é um simulador de um processador simples com uma ISA fictícia.
A leitura das instruções é feita em C e a execução é realizada e Assembly.

## Objetivo da Atividade
 Compreender o funcionamento básico de um processador.
 Simular a execução de instruções em uma arquitetura simples.
 Utilizar integração entre C e Asembly.
 Aprender sobre manipulação de registradores e instruções.

 ## Como funciona
 O projeto executa instruções escritas em formato hexadecimal (ex: 1005, 2003, 4000) a partir de um arquivo .txt.

 cada intrução de 16 bits é dividida em:
  **4 bits superiores**: opcode (identifica a operação)
  **12 bits inferiores** operando (valor a ser usado)

  ## Instruções suportadas (ISA)
  | Opcode | Instrução | Descrição |
  |--------|-----------|-----------|
  |  1xxx  |   LOAD    | Carrega o valor de `xxx` no registrador A |
  |  2xxx  |   ADD     | Soma `xxx` com A |
  |  3xxx  |   SUB     | Subtrai `xxx` de A |
  |  4xxx  |   PRINT   | Imprime o valor atual de A |
  |  outro |   UNKNOWW | Instrução desonhecida |

  ## Exemplo de entrada (`instruções.txt`)
  ```txt
  1005  ; A = 5
  2003  ; A = A + 3 = 8
  3002  ; A = A - 2 = 6
  4000  ; imprime A -> "Valor de A: 6"
  ```
  

## Como usar
# Compilar (Linux):

```bash
nasm -f elf32 interpretador.asm -o interpretador.o
gcc -m32 main.c interpretador.o -o interpretador
```
