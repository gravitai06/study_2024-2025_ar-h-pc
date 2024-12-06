%include 'in_out.asm'

SECTION .data
msg db 'Результат: ', 0

SECTION .text
global _start

_start:
    ; ---- Вычисление выражения (3 + 2) * 4 + 5
    mov eax, 3          ; eax = 3
    add eax, 2          ; eax = eax + 2 = 5
    mov ebx, 4          ; ebx = 4
    imul eax, ebx       ; eax = eax * ebx = 5 * 4 = 20
    add eax, 5          ; eax = eax + 5 = 25

    ; ---- Вывод результата на экран
    mov edi, eax        ; Сохраняем результат в `edi` для вывода
    mov eax, msg        ; Устанавливаем `eax` на строку сообщения
    call sprint         ; Печатаем "Результат: "
    mov eax, edi        ; Перемещаем результат в `eax` для печати
    call iprintLF       ; Печать результата с переходом на новую строку
    call quit           ; Завершение программы

