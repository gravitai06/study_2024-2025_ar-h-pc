%include 'in_out.asm'

section .data
    msg1 db 'Наименьшее число: ',0h
    A dd 99       ; Значение A
    B dd 29       ; Значение B
    C dd 26       ; Значение C

section .bss
    min resd 1    ; Переменная для хранения наименьшего значения

section .text
    global _start

_start:
    ; Инициализация min значением A
    mov eax, [A]
    mov [min], eax    ; min = A

    ; Сравниваем min с B
    cmp eax, [B]
    jg update_B       ; Если min > B, переходим к обновлению B
    ; Иначе, min остается тем же
    jmp check_C

update_B:
    mov eax, [B]
    mov [min], eax    ; min = B

check_C:
    ; Сравниваем min с C
    cmp eax, [C]
    jg update_C       ; Если min > C, переходим к обновлению C
    ; Иначе, min остается тем же
    jmp fin

update_C:
    mov eax, [C]
    mov [min], eax    ; min = C

fin:
    ; Вывод результата
    mov eax, msg1
    call sprint        ; Вывод сообщения 'Наименьшее число: '
    mov eax, [min]
    call iprintLF      ; Вывод min
    call quit          ; Выход

