%include 'in_out.asm'
SECTION .data
msg db "Результат: ",0

SECTION .text
global _start
_start:
   pop ecx            ; Извлекаем количество аргументов в `ecx`
   pop edx            ; Извлекаем имя программы из стека в `edx`
   sub ecx, 1         ; Уменьшаем `ecx` на 1 (чтобы не учитывать имя программы)
   mov esi, 0         ; Инициализируем `esi` значением 0 для суммы

next:
   cmp ecx, 0         ; Проверяем, есть ли ещё аргументы
   jz _end            ; Если аргументов нет, выходим из цикла (переход к `_end`)
   pop eax            ; Извлекаем следующий аргумент из стека
   call atoi          ; Преобразуем аргумент в число (результат в `eax`)

   ; Вычисляем f(x) = 3(10 + eax)
    add eax, 10 ; eax = eax + 10
    mov ebx, 3 ; Устанавливаем коэффициент 3
    imul eax, ebx ; eax = eax * 3 (получаем f(x))

   add esi, eax       ; Добавляем f(x) к промежуточной сумме `esi`
   dec ecx            ; Уменьшаем `ecx` на 1
   jmp next           ; Переход к обработке следующего аргумента

_end:
   mov eax, msg       ; Выводим сообщение "Результат: "
   call sprint
   mov eax, esi       ; Записываем сумму в регистр `eax`
   call iprintLF      ; Печать результата
   call quit          ; Завершение программы
