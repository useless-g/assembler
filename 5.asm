format PE console

entry start

include '%fasminc%/win32w.inc'

section '.data' data readable writeable

specp db '%d', 0Dh, 0Ah, 0
specp_char db '%c', 0
specs db '%d', 0
Title db 'My fIrsT prOgraM on Asm', 0
n dw 0
section '.text' code readable executable

start:

        xor ecx, ecx


next_char:

        cmp byte[Title + ecx], 0
        je end_of_string
        inc ecx
        jmp next_char

end_of_string:

        xor ebx, ebx


output_char:
        cmp ecx, 0FFFFFFFFh
        je the_end
        push ecx
        cmp byte[Title + ebx], 65
        jae bigg
        cinvoke printf, specp_char, dword[Title + ebx]
        pop ecx
        inc ebx
        loop output_char

bigg:

        cmp byte[Title + ebx], 90
        jbe change
        cinvoke printf, specp_char, dword[Title + ebx]
        pop ecx
        inc ebx
        dec ecx
        jmp output_char
change:

        mov al, byte[Title + ebx]
        add al, 32
        mov byte[Title + ebx], al
        cinvoke printf, specp_char, dword[Title + ebx]
        pop ecx
        inc ebx
        dec ecx
        jmp output_char

the_end:
        cinvoke scanf, specs, n

        invoke ExitProcess, dword 0

section '.idata' data import readable writeable

library kernel32, 'kernel32.dll', \
        msvcrt, 'msvcrt.dll'

import kernel32, ExitProcess, 'ExitProcess'
import msvcrt, printf, 'printf', scanf, 'scanf'