section .data
    ; Mensagens de saída
    msg_add db  "ADD ", 0
    msg_sub db  "SUB ", 0
    msg_mov db  "MOV ", 0
    msg_jmp db  "JMP ", 0
    msg_hex db  "0x", 0
    msg_newline db  10, 0
    msg_unknown db  "Instrução desconhecida: ", 0

section .text
    global interpretar_instrucoes

; Função para imprimir strings
print_string:
    push ebp
    mov ebp, esp
    push ebx
    
    mov eax, 4      ; sys_write
    mov ebx, 1      ; stdout
    mov ecx, [ebp+8] ; string
    mov edx, 0
    
    ; Calcula o tamanho da string
    .len_loop:
    cmp byte [ecx+edx], 0
    je .len_done
    inc edx
    jmp .len_loop
    .len_done:
    
    int 0x80        ; chamada do sistema
    
    pop ebx
    mov esp, ebp
    pop ebp
    ret

interpretar_instrucoes:
    push ebp
    mov ebp, esp
    push ebx
    
    ; Obtém o ponteiro para a instrução hexadecimal
    mov ebx, [ebp+8]
    
    ; Converte a string hexadecimal para valor numérico
    mov eax, 0
    mov ecx, 0
    .convert_loop:
    movzx edx, byte [ebx+ecx]
    cmp edx, 0
    je .convert_done
    
    shl eax, 4
    
    cmp edx, '9'
    jbe .digit
    sub edx, 7
    .digit:
    sub edx, '0'
    add eax, edx
    
    inc ecx
    jmp .convert_loop
    .convert_done:
    
    ; Extrai o código da operação (4 bits mais significativos)
    mov edx, eax
    shr edx, 12
    
    ; Interpreta a instrução baseada no código de operação
    cmp edx, 0x0
    je .inst_add
    cmp edx, 0x1
    je .inst_sub
    cmp edx, 0x2
    je .inst_mov
    cmp edx, 0x3
    je .inst_jmp
    jmp .inst_unknown
    
    .inst_add:
    push msg_add
    call print_string
    add esp, 4
    jmp .print_hex
    
    .inst_sub:
    push msg_sub
    call print_string
    add esp, 4
    jmp .print_hex
    
    .inst_mov:
    push msg_mov
    call print_string
    add esp, 4
    jmp .print_hex
    
    .inst_jmp:
    push msg_jmp
    call print_string
    add esp, 4
    jmp .print_hex
    
    .inst_unknown:
    push msg_unknown
    call print_string
    add esp, 4
    
    .print_hex:
    push msg_hex
    call print_string
    add esp, 4
    
    ; Imprime o valor hexadecimal
    push eax
    call print_hex_value
    add esp, 4
    
    push msg_newline
    call print_string
    add esp, 4
    
    pop ebx
    mov esp, ebp
    pop ebp
    ret

; Função para imprimir valor hexadecimal
print_hex_value:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    
    mov eax, [ebp+8]
    mov ecx, 8       ; 8 dígitos hexadecimais
    mov edi, buffer
    add edi, 7       ; posição final do buffer
    
    .convert_loop:
    mov ebx, eax
    and ebx, 0xF     ; pega o último nibble
    cmp ebx, 9
    jbe .digit
    add bl, 7        ; ajusta para A-F
    .digit:
    add bl, '0'
    mov [edi], bl
    dec edi
    shr eax, 4
    loop .convert_loop
    
    ; Encontra o primeiro dígito não zero
    mov ecx, buffer
    .find_nonzero:
    cmp byte [ecx], '0'
    jne .print
    inc ecx
    cmp ecx, buffer+7
    jb .find_nonzero
    
    .print:
    mov eax, 4       ; sys_write
    mov ebx, 1       ; stdout
    mov edx, buffer+8
    sub edx, ecx     ; calcula o tamanho
    int 0x80
    
    pop edi
    pop esi
    pop ebx
    mov esp, ebp
    pop ebp
    ret

section .bss
    buffer resb 8

