# Bootloader

Este é um bootloader simples desenvolvido em Assembly para x86, utilizando o modo real da BIOS.

## Funcionalidades

*   **Entrada do Usuário:** Permite que o usuário digite uma frase.
*   **Concatenação de Strings:** Aglutina a frase digitada pelo usuário a uma frase predefinida.
*   **Exibição na Tela:** Exibe a string combinada na tela.

## Exemplo

Se o usuário digitar "Pedro", o bootloader exibirá "Olá, Pedro".

## Estrutura do Código

O código fonte ([src/bootloader.asm](src/bootloader.asm)) é escrito em Assembly e está organizado da seguinte forma:

*   **Inicialização:** Configura os segmentos e limpa a tela.
*   **Prompt:** Exibe uma mensagem solicitando a entrada do usuário.
*   **Leitura da Entrada:** Lê a entrada do usuário através do teclado.
*   **Processamento:** Concatena a entrada do usuário com a mensagem predefinida.
*   **Exibição do Resultado:** Imprime a mensagem final na tela.

## Funções Principais

*   [`print_string`](src/bootloader.asm): Imprime uma string na tela.
*   [`read_string`](src/bootloader.asm): Lê uma string do teclado.
*   [`copy_string`](src/bootloader.asm): Copia uma string de um local para outro.

## Dados

*   `prompt_msg`: Mensagem de prompt exibida ao usuário.
*   `greeting_msg`: Mensagem de saudação predefinida.
*   `user_input`: Buffer para armazenar a entrada do usuário.
*   `output_buffer`: Buffer para armazenar a string combinada.

## Como executar

1. Compilar com NASM:

```bash
nasm -f bin bootloader.asm -o bootloader.bin
```

2. Testar com QEMU:
```bash
qemu-system-x86_64 -fda bootloader.bin
```

## Funcionamento

![Demonstração do Funcionamento]("./img/funcionamento.gif")
