section .data
	dividendo dd 112
	divisor dd 2
	mensaje db 'Resultado: ',0
	salto db 10

section .bss
	buffer resb 12

section .text
	global _start

_start:
	;cargar los datos
	mov eax,[dividendo]
	xor edx,edx
	mov ebx, [divisor]

	;el cociente se guarda en EAX
	div ebx

	;Convertir EAX a ASCII
	mov ecx, buffer + 11
	mov byte [ecx],0

.convertir:
	dec ecx
	xor edx,edx
	mov ebx,10
	div ebx
	add dl, '0'
	mov [ecx],dl
	test eax,eax
	jnz .convertir

	;mostrar el mensaje
	mov eax,4
	mov ebx,1
	mov ecx,mensaje
	mov edx,10
	int 0x80

	;mostrar el resultado
	mov eax,4
	mov ebx,1
	mov edx,buffer + 11
	sub edx,ecx
	int 0x80

	;mostrar salto de linea
	mov eax,4
	mov ebx,1
	mov ecx,salto
	mov edx,1
	int 0x80

	;fin del programa
	mov eax,1
	mov ebx,ebx
	int 0x80
