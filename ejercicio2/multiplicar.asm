section .data
	num1 db 12
	num2 db 7
	mensaje db 'Resultado: ',0
	salto db 10

section .bss
	resultado resw 1
	buffer resb 6

section .text
	global _start

_start:
	;movemos los numeros a los registros de 8 bits
	mov al,[num1]
	mov bl,[num2]

	;realizamos la multiplicacion
	mul bl

	;alamcenamos el resultado
	mov [resultado],ax

	;mostrar mensaje
	mov eax,4
	mov ebx,1
	mov ecx,mensaje
	mov edx,10
	int 0x80

	; convertir resultado a ASCII decimal
	mov ax,[resultado]
	xor cx,cx
	mov bx,10
	mov esi,buffer + 5

.convertir:
	xor dx,dx
	div bx
	add dl, '0'
	dec esi
	mov [esi],dl
	inc cx
	test ax,ax
	jnz .convertir

	;Imprimir el numero modificado
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

	;fin del programa
	mov eax,1
	xor ebx,ebx
	int 0x80
