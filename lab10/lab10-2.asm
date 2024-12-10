SECTION .data
    prompt db "Как Вас зовут?", 10  ; Сообщение приглашения с новой строкой
    prompt_len equ $ - prompt        ; Длина сообщения

    output_msg db "Меня зовут ", 0   ; Сообщение для записи в файл
    output_msg_len equ $ - output_msg ; Длина сообщения

    filename db "name.txt", 0        ; Имя файла для создания

SECTION .bss
    name resb 64                     ; Буфер для хранения введенного имени (64 байта)

SECTION .text
    global _start

_start:
    ; Вывод приглашения "Как Вас зовут?"
    mov eax, 4                       ; syscall: sys_write
    mov ebx, 1                       ; дескриптор: stdout
    mov ecx, prompt                  ; адрес сообщения
    mov edx, prompt_len              ; длина сообщения
    int 0x80                         ; вызов ядра

    ; Чтение имени пользователя с клавиатуры
    mov eax, 3                       ; syscall: sys_read
    mov ebx, 0                       ; дескриптор: stdin
    mov ecx, name                    ; адрес буфера
    mov edx, 64                      ; количество байт для чтения
    int 0x80                         ; вызов ядра

    ; Создание файла name.txt
    mov eax, 5                       ; syscall: sys_open
    mov ebx, filename                ; имя файла
    mov ecx, 0101b                   ; флаги: O_CREAT | O_WRONLY
    mov edx, 0644                    ; права доступа: rw-r--r--
    int 0x80                         ; вызов ядра
    mov edi, eax                     ; сохранение дескриптора файла

    ; Запись "Меня зовут " в файл
    mov eax, 4                       ; syscall: sys_write
    mov ebx, edi                     ; дескриптор файла
    mov ecx, output_msg              ; сообщение "Меня зовут "
    mov edx, output_msg_len          ; длина сообщения
    int 0x80                         ; вызов ядра

    ; Запись имени пользователя в файл
    mov eax, 4                       ; syscall: sys_write
    mov ebx, edi                     ; дескриптор файла
    mov ecx, name                    ; адрес введенного имени
    mov edx, 64                      ; максимальная длина записи
    int 0x80                         ; вызов ядра

    ; Закрытие файла
    mov eax, 6                       ; syscall: sys_close
    mov ebx, edi                     ; дескриптор файла
    int 0x80                         ; вызов ядра

    ; Завершение программы
    mov eax, 1                       ; syscall: sys_exit
    xor ebx, ebx                     ; код возврата 0
    int 0x80                         ; вызов ядра
