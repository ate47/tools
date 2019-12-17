.data
	tableau: # 2^64 = 10^20
		.byte 0 # 1
		.byte 0
		.byte 0
		.byte 0
		.byte 0 # 5
		.byte 0
		.byte 0
		.byte 0
		.byte 0
		.byte 0 # 10
		.byte 0
		.byte 0
		.byte 0
		.byte 0
		.byte 0 # 15
		.byte 0
		.byte 0
		.byte 0
		.byte 0
		.byte 0 # 20
		.byte 0
		.byte 0

.text   #debut du segment de code

.global affiche_entier
affiche_entier:
	
	mov $tableau, %rsi	    # T: @ du tableau
	xor %rdi, %rdi			# n: taille
tq:
	mov $10, %rcx
	xor %rdx, %rdx
	div %rcx									# a/=10
	add $48, %rdx							# d = '0' + a
	movb %dl, (%rsi, %rdi, 1)	# t[n++] = d
	inc %rdi
	
	test %rax, %rax						# while(rax)
	je retourne
	jmp tq
retourne:
	xor %r8, %r8							# r8: i=0
	mov %rdi, %r9							# r9: j=n-1
	dec %r9
tq2:
	movb (%rsi, %r8, 1), %al	# echanger(T[j], T[i])
	movb (%rsi, %r9, 1), %dl 
	movb %dl, (%rsi, %r8, 1)
	movb %al, (%rsi, %r9, 1)
	inc %r8										# i++
	dec %r9										# j--
	
	cmp %r8, %r9							# while i <= j
	jle aff
	jmp tq2
aff:												# write(stdout, T, n)
	mov %rdi, %rdx
	mov $1, %rax
	mov $1, %rdi
	syscall
fin:
	ret

