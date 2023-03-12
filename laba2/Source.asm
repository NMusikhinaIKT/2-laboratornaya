.686
.model flat,stdcall
.stack 100h
.data 

arr dw 045B2h,01C2Dh,0203Eh ; массив исходных данных
m dw 0000000011111111b ; обьявление маски для инверсии младших байтов у X Y Z

.code
ExitProcess PROTO STDCALL :DWORD
Start:

xor eax,eax ;очистка регистра EAX
xor ebx,ebx ;очистка регистра EBX
xor ecx,ecx ;очистка регистра ECX
xor edx,edx ;очистка регистра EDX

lea esi,[arr]
lea edi,[arr]
mov ecx,3 ; указываем в регистре ECX количество итераций
mov bx,m ; записал маску в bx в регистр EBX
@cycle: ; начало цикла
lodsw ; прочитал число 
xor ax,bx ; XORом число на маску, которая находится в bx
stosw ; записал число
loop @cycle ; конец цикла

lea esi,[arr]
mov cx,ax ; значение в ax в cx
lodsw ; прочитал число
mov bx,ax ; значение в регистре ax в регистр bx
lodsw ; прочитал число
mov dx, ax
mov ax, bx
mov bx, dx
xor edx, edx
and ax, bx
mov dx, ax
mov ax, cx
mov cx, dx
mov ebx, 8h; если bx то с переносом
mul ebx
add eax,ecx
;stc установка флага CY - переноса
jc pp1; флаг переноса равен 1
jnc pp2; флаг переноса равен 0

pp1:
ror eax, 16
jmp ifc

pp2:
mov ebx, 9911Eh
sub eax, ebx
jmp ifc

ifc:
mov ebx, 0991h
cmp eax, ebx
jl adr1
jg adr2
je adr1

adr1:
or eax, 2381h
jmp exit

adr2:
xor eax, 0080h

exit:
Invoke ExitProcess,1
End Start
