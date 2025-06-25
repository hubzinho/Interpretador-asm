section .data
    regA dd 0              ; registrador A
    msg_unknown db "Instrucao desconhecida!", 10, 0
    msg_val db "Valor de A: %d", 0
    newline db 10, 0

section .text
    global executar_instrucao
    extern printf

executar_instrucao:
    push ebp
    mov ebp, esp
    push eax
    push ebx
    push ecx
    push edx

    mov eax, [ebp+8]       ; pega a instrução recebida
    mov ebx, eax           ; cópia da instrução
    shr ebx, 12            ; pega opcode (4 bits mais altos)

    ; Extrai operando (12 bits restantes)
    mov ecx, eax
    and ecx, 0x0FFF

    cmp ebx, 1
    je .load
    cmp ebx, 2
    je .add
    cmp ebx, 3
    je .sub
    cmp ebx, 4
    je .print
    jmp .unknown

.load:
    mov [regA], ecx
    jmp .fim

.add:
    mov eax, [regA]
    add eax, ecx
    mov [regA], eax
    jmp .fim

.sub:
    mov eax, [regA]
    sub eax, ecx
    mov [regA], eax
    jmp .fim

.print:
    push dword [regA]
    push msg_val
    call printf
    add esp, 8
    jmp .fim

.unknown:
    push msg_unknown
    call printf
    add esp, 4

.fim:
    pop edx
    pop ecx
    pop ebx
    pop eax
    mov esp, ebp
    pop ebp
    ret
