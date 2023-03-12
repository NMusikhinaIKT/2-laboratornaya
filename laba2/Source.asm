.686
.model flat,stdcall
.stack 100h
.data 

arr dw 045B2h,01C2Dh,0203Eh ; ������ �������� ������
m dw 0000000011111111b ; ���������� ����� ��� �������� ������� ������ � X Y Z

.code
ExitProcess PROTO STDCALL :DWORD
Start:

xor eax,eax ;������� �������� EAX
xor ebx,ebx ;������� �������� EBX
xor ecx,ecx ;������� �������� ECX
xor edx,edx ;������� �������� EDX

lea esi,[arr]
lea edi,[arr]
mov ecx,3 ; ��������� � �������� ECX ���������� ��������
mov bx,m ; ������� ����� � bx � ������� EBX
@cycle: ; ������ �����
lodsw ; �������� ����� 
xor ax,bx ; XOR�� ����� �� �����, ������� ��������� � bx
stosw ; ������� �����
loop @cycle ; ����� �����

lea esi,[arr]
mov cx,ax ; �������� � ax � cx
lodsw ; �������� �����
mov bx,ax ; �������� � �������� ax � ������� bx
lodsw ; �������� �����
mov dx, ax
mov ax, bx
mov bx, dx
xor edx, edx
and ax, bx
mov dx, ax
mov ax, cx
mov cx, dx
mov ebx, 8h; ���� bx �� � ���������
mul ebx
add eax,ecx
;stc ��������� ����� CY - ��������
jc pp1; ���� �������� ����� 1
jnc pp2; ���� �������� ����� 0

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
