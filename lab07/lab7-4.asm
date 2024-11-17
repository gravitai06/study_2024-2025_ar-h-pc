%include 'in_out.asm'

section .data
    prompt_x db 'Введите x: ', 0
    prompt_a db 'Введите a: ', 0
    result_msg db 'Результат f(x) = ', 0

section .bss
    x resb 10
    a resb 10
    result resb 10

section .text
    global _start

_start:
    ; ---------- Вывод сообщения 'Введите x: '
    mov eax, prompt_x
    call sprint
    
    ; ---------- Ввод 'x'
    mov ecx, x
    mov edx, 10
    call sread
    
    ; ---------- Преобразование 'x' из строки в число
    mov eax, x
    call atoi
    mov [x], eax ; Сохраняем преобразованное значение x

    ; ---------- Вывод сообщения 'Введите a: '
    mov eax, prompt_a
    call sprint
    
    ; ---------- Ввод 'a'
    mov ecx, a
    mov edx, 10
    call sread
    
    ; ---------- Преобразование 'a' из строки в число
    mov eax, a
    call atoi
    mov [a], eax ; Сохраняем преобразованное значение a

    ; ---------- Проверка условия x < 5
    mov eax, [x]
    cmp eax, 5
    jl calculate_ax  ; если x < 5, переходим к вычислению ax

calculate_x_minus_5:
    ; Вычисляем f(x) = x - 5
    mov eax, [x]
    sub eax, 5
    mov [result], eax
    jmp print_result

calculate_ax:
    ; Вычисляем f(x) = ax
    mov eax, [a]
    imul eax, [x]
    mov [result], eax

print_result:
    ; ---------- Вывод результата
    mov eax, result_msg
    call sprint  ; Печатаем сообщение

    mov eax, [result]
    call iprintLF ; Печатаем результат
    
    ; ---------- Завершение программы
    call quit

