%include 'in_out.asm' ; подключение внешнего файла

section .data
    msg1 db 'Введите B: ', 0h
    msg2 db 'Наибольшее число: ', 0h
    A dd 20
    C dd 50

section .bss
    max resb 10
    B resb 10

section .text
    global _start

_start:
    ; -------- Вывод сообщения 'Введите B: ' --------
    mov eax, msg1
    call sprint

    ; -------- Ввод 'B' --------
    mov ecx, B
    mov edx, 10
    call sread

    ; -------- Преобразование 'B' из символа в число --------
    mov eax, B
    call atoi ; Вызов подпрограммы перевода символа в число
    mov [B], eax ; Запись преобразованного числа в 'B'

    ; -------- Записываем 'A' в переменную 'max' --------
    mov eax, [A]
    mov [max], eax

    ; -------- Сравниваем 'A' и 'B' --------
    mov eax, [B]
    cmp eax, [max]
    jg update_max

    ; -------- Сравниваем 'max' и 'C' --------
    mov eax, [C]
    cmp eax, [max]
    jg update_max

    jmp print_max

update_max:
    mov [max], eax

print_max:
    ; -------- Вывод сообщения 'Наибольшее число: ' --------
    mov eax, msg2
    call sprint

    ; -------- Вывод 'max' --------
    mov eax, [max]
    call iprintLF

    ; -------- Завершение программы --------
    call quit
