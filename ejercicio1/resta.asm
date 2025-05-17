section .data
	num1 dw 100
	num2 dw 30
	num3 dw 10
	mensaje db 'Resultado: ',0
	salto db 10,0

section .bss
	resultado resw 1
	buffer resb 6

section .text
	global _start

_start:
	; Cargamos los numero en los registros ax,bx,cx
	mov ax,[num1]
	mov bx,[num2]
	mov cx,[num3]

	;resta de los numeros
	sub ax,bx
	sub ax,cx

	;Almacenamos el resultado
	mov [resultado], ax

	;imprimir texto de resultado
	mov eax,4
	mov ebx,1
	mov ecx,mensaje
	mov edx,10
	int 0x80

	;convertir AX a decimal ASCII
	mov ax,[resultado]
	xor cx,cx
	mov bx,10
	mov esi, buffer + 5

convertir:
	xor dx,dx
	div bx
	add dl,'0'
	dec esi
	mov [esi],dl
	inc cx
	test ax,ax
	jnz convertir

	;imprimir el numero
	mov eax,4
	mov ebx,1
	mov ecx,esi
	mov edx,ecx
	int 0x80

	;imprimir salto de linea
	mov eax,4
	mov ebx,1
	mov ecx,salto
	mov edx,1
	int 0x80

	;terminar el programa
	mov eax,1
	xor ebx,ebx
	int 0x80
