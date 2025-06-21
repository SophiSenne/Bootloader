; bootloader.asm

[BITS 16]           ; Modo real de 16 bits
[ORG 0x7C00]        ; Bootloader carregado em 0x7C00

start:
    ; Configurar segmentos
    mov ax, 0x0000
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    
    ; Exibir mensagem de prompt
    mov si, prompt_msg
    call print_string
    
    ; Ler entrada do usuário
    mov di, user_input 
    call read_string
    
    mov bh, 0           
    mov dh, 1           
    mov dl, 0           
    int 0x10
    
    ; Copiar "Olá, " para o buffer de saída
    mov si, greeting_msg
    mov di, output_buffer
    call copy_string
    
    ; Aglutinar nome do usuário
    mov si, user_input
    call copy_string  
    
    ; Exibir resultado final
    mov si, output_buffer
    call print_string
    
    ; Loop infinito
    jmp $

; Função para imprimir string
print_string:
    push ax
    push bx
    
.loop:
    lodsb               
    test al, al         
    jz .done
    
    mov ah, 0x0E        
    mov bh, 0           
    mov bl, 0x07        
    int 0x10            
    
    jmp .loop
    
.done:
    pop bx
    pop ax
    ret

; Função para ler string do teclado
read_string:
    push ax
    push bx
    push dx
    
    mov dx, di          
    
.read_loop:
    mov ah, 0x00        
    int 0x16            
    
    cmp al, 0x0D        
    je .done
    
    cmp al, 0x08        
    je .backspace
    
    cmp al, 0x20        
    jb .read_loop
    
    ; Verificar se buffer não está cheio
    mov bx, di
    sub bx, dx
    cmp bx, 31          
    jge .read_loop
    
    ; Armazenar caractere
    stosb               
    
    ; Exibir caractere
    mov ah, 0x0E
    mov bh, 0
    mov bl, 0x07
    int 0x10
    
    jmp .read_loop
    
.backspace:
    cmp di, dx          
    je .read_loop
    
    dec di              
    mov byte [di], 0   
    
    ; Mover cursor para trás
    mov ah, 0x0E
    mov al, 0x08        
    int 0x10
    mov al, 0x20        
    int 0x10
    mov al, 0x08        
    int 0x10
    
    jmp .read_loop
    
.done:
    mov byte [di], 0    ; Terminar string com null
    
    pop dx
    pop bx
    pop ax
    ret

; Função para copiar string
copy_string:
    push ax
    
.copy_loop:
    lodsb               
    test al, al         
    jz .copy_done
    
    stosb               
    jmp .copy_loop
    
.copy_done:
    pop ax
    ret

; Dados
prompt_msg      db 'Digite seu nome: ', 0
greeting_msg    db 'Ola, ', 0
user_input      times 32 db 0    ; Buffer para entrada do usuário
output_buffer   times 64 db 0    ; Buffer para saída combinada

times 510-($-$$) db 0
dw 0xAA55               