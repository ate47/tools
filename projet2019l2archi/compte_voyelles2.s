.data
	compteur:
		.quad 0 # quad compteur
	i:
		.quad 0 # quad i
	texte:
		.quad 0 # char* texte

	message_il_y_a:
		.string "Il y a "
	message_voyelle:
		.string " voyelle\n"
	message_voyelles:
		.string " voyelles\n"
	message_usage:
		.string "Il faut au moins un argument!\n"

.text
.global _start

# fonction qui regarde si RAX est une voyelle et place dans RAX 1 si c'est le cas
# 0 sinon utilise RBX

# int est_voyelle(int c) {
est_voyelle:
	# if (c == 'a' || c == 'e' || c == 'y' || c == 'u' || c = 'i' || c == 'o')
	mov $'a', %rbx
	cmp %rax, %rbx
	je est_voyelle_if     # c == 'a'

	mov $'e', %rbx
	cmp %rax, %rbx
	je est_voyelle_if     # c == 'e'

	mov $'y', %rbx
	cmp %rax, %rbx
	je est_voyelle_if     # c == 'y'

	mov $'u', %rbx
	cmp %rax, %rbx
	je est_voyelle_if     # c == 'u'

	mov $'i', %rbx
	cmp %rax, %rbx
	je est_voyelle_if     # c == 'i'

	mov $'o', %rbx
	cmp %rax, %rbx
	jne est_voyelle_else  # c == 'o'
est_voyelle_if:           # ) {
	mov $1, %rax 
	ret                   #   return 1
est_voyelle_else:         # } else {
	xor %rax, %rax
	ret                   #   return 0
	                      # }
# }
 
 _start:

# verification des arguments

	pop %rax
	cmp $2, %rax
	jge arg_if_fin               # if (argc < 2)

	mov $1, %rax
	mov $1, %rdi
	mov $message_usage, %rsi
	mov $30, %rdx
	syscall                     #   write(stdout, message_usage, 30)

	mov $60, %rax
	mov $-1, %rdi
	syscall  				    #   exit(-1)
arg_if_fin:

	pop %rax # suppression de argv[0]

	pop %rax
	mov %rax, texte             # texte = argv[1]

# lecture

lecture_do_debut:
	# for (i = 0; texte[i] != 0; i++) {
	xor %rax, %rax
	mov %rax, i                 # i = 0

lecture_for_condition:
	mov texte, %rdx
	mov i, %rbx
	xor %rax, %rax
	mov (%rdx, %rbx, 1), %al    # texte[i]

	test %rax, %rax
	je lecture_for_fin          # texte[i] != '\0'

	call est_voyelle
	test %rax, %rax
	je lecture_for_pas          #   if (est_voyelle(texte[i]))

	mov compteur, %rax
	inc %rax
	mov %rax, compteur          #     compteur++

lecture_for_pas:
	mov i, %rax
	inc %rax
	mov %rax, i                 # i++
	jmp lecture_for_condition
	# }

lecture_for_fin:

	pop %rax
	mov %rax, texte             # texte = argv[j++]
	
	test %rax, %rax
	jne lecture_do_debut        # } while (texte != NULL)

# affichage

	mov $1, %rax
	mov $1, %rdi
	mov $message_il_y_a, %rsi
	mov $7, %rdx
	syscall                     # write(stdout, message_il_y_a, 7)

	mov compteur, %rax
	call affiche_entier         # affiche_entier(compteur)

	mov compteur, %rax
	mov $1, %rbx
	cmp %rax, %rbx
	jge affichage_if_else       # if (compteur > 1)

	mov $1, %rax
	mov $1, %rdi
	mov $message_voyelles, %rsi
	mov $11, %rdx
	syscall                     #   write(stdout, message_voyelles, 11)

	jmp affichage_if_fin

affichage_if_else:              # else

	mov $1, %rax
	mov $1, %rdi
	mov $message_voyelle, %rsi
	mov $10, %rdx
	syscall                     #   write(stdout, message_voyelle, 10)

affichage_if_fin:


	mov $60, %rax				# exit(0)
	xor %rdi, %rdi
	syscall

