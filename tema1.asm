%include "io.inc"


section .data
    %include "input.inc"
    incorrect_base db "Baza incorecta", 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    xor ecx, ecx ;initial, setat ca index-ul 0 al vectorilor
    
vector_run:

    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    
    mov eax, dword [nums_array + 4*ecx] ;mutam in eax deimpartitul
    mov ebx, dword [base_array + 4*ecx] ;mutam in ebx impartitorul
    
    cmp ebx, 2
    jl not_valid_base
    cmp ebx, 16
    jg not_valid_base
    
    cmp eax, 0 ;poate fi negativ datorita faptului ca e signed
    jl nevermind ;in acest caz, nu trebuie bagat in simple
  
    cmp eax, ebx
    jl simple
    
nevermind:
    push ecx ;pentru a tine minte unde am ramas in vectori
    xor ecx, ecx ;ecx devine un count pentru push/pop
    
base_convert:

    div ebx ;impartim la baza
    inc ecx ;pentru a sti cate pop-uri trebuie facute la print
    push edx ;mutam restul pe stiva
    xor edx, edx ;pentru a stabili partea high a deimpartitului 0
    cmp eax, ebx
    jge base_convert
    
    push eax ;ramane ultimul rest
    inc ecx
    
pop_and_print:

    pop eax
    
    cmp eax, 10 ;il va converti intr-un char corespunzator numarului din eax
    jl set_number
    
    add eax, 87 ;il va converti intr-un char corespunzator char-ului din eax
    jmp just_print 
    
set_number:
    add eax, 48
    
just_print:
    PRINT_CHAR eax
    dec ecx
    cmp ecx, 0 ;printeaza resturile pana egaleaza numarul de push-uri
    jne pop_and_print
    
    NEWLINE
    
    pop ecx ;devine din nou nums-ul de la inceput
    inc ecx ;am trecut printr-o pozitie din vectori
    xor ebx, ebx
    mov ebx, dword [nums]
    cmp ecx, ebx
    jl vector_run
    jmp return
    
not_valid_base:
    inc ecx ;mai avansam o pozitie in vector
    PRINT_STRING incorrect_base
    NEWLINE
    xor ebx, ebx
    mov ebx, dword [nums]
    cmp ecx, ebx
    jl vector_run
    jmp return
    
simple:
    inc ecx ;mai avansam o pozitie in vector
    cmp eax, 10
    jl set_simple_number ;analog set_number
    
    add eax, 87
    jmp just_print_simple ;analog just_print
    
set_simple_number:
    add eax, 48
    
just_print_simple:
    PRINT_CHAR eax
    NEWLINE
    xor ebx, ebx
    mov ebx, dword [nums]
    cmp ecx, ebx
    jl vector_run
    
return:
    mov esp, ebp
    ret
