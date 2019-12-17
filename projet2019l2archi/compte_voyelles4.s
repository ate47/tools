.data
	compteur:
		.quad 0
		.quad 0
		.quad 0
		.quad 0
		.quad 0
		.quad 0 # quad compteur[6]
	i:
		.quad 0 # quad i
	texte:
		.quad 0 # char* texte
	buffer:  # char buffer[2]
		.byte 0
		.byte '\n'

	message_occurence_de:
		.string " occurrence de "
	message_occurences_de:
		.string " occurrences de "
	message_usage:
		.string "Il faut au moins un argument!\n"

.text
.global _start

# fonction qui regarde si RAX est une voyelle et place dans RAX 1 si c'est le cas
# 0 sinon utilise RBX

# int est_voyelle(int c) {
est_voyelle:
	# if (c == 'a' || c == 'e' || c == 'y' || c == 'u' || c = 'i' || c == 'o'
	#   || c == 'A' || c == 'E' || c == 'Y' || c == 'U' || c = 'I' || c == 'O)
	mov $'a', %rbx
	cmp %rax, %rbx
	jne est_voyelle_if1   # c == 'a'

	mov $1, %rax
	ret                   # return 1

est_voyelle_if1:
	mov $'e', %rbx
	cmp %rax, %rbx
	jne est_voyelle_if2   # c == 'e'

	mov $2, %rax
	ret                   # return 2

est_voyelle_if2:
	mov $'y', %rbx
	cmp %rax, %rbx
	jne est_voyelle_if3   # c == 'y'

	mov $3, %rax
	ret                   # return 3

est_voyelle_if3:
	mov $'u', %rbx
	cmp %rax, %rbx
	jne est_voyelle_if4   # c == 'u'

	mov $4, %rax
	ret                   # return 4

est_voyelle_if4:
	mov $'i', %rbx
	cmp %rax, %rbx
	jne est_voyelle_if5   # c == 'i'

	mov $5, %rax
	ret                   # return 5

est_voyelle_if5:
	mov $'o', %rbx
	cmp %rax, %rbx
	jne est_voyelle_if6   # c == 'o'

	mov $6, %rax
	ret                   # return 6

est_voyelle_if6:
	mov $'A', %rbx
	cmp %rax, %rbx
	jne est_voyelle_if7     # c == 'A'

	mov $1, %rax
	ret                   # return 1

est_voyelle_if7:
	mov $'E', %rbx
	cmp %rax, %rbx
	jne est_voyelle_if8     # c == 'E'

	mov $2, %rax
	ret                   # return 2

est_voyelle_if8:
	mov $'Y', %rbx
	cmp %rax, %rbx
	jne est_voyelle_if9     # c == 'Y'

	mov $3, %rax
	ret                   # return 3

est_voyelle_if9:
	mov $'U', %rbx
	cmp %rax, %rbx
	jne est_voyelle_if10     # c == 'U'

	mov $4, %rax
	ret                   # return 4

est_voyelle_if10:
	mov $'I', %rbx
	cmp %rax, %rbx
	jne est_voyelle_if11     # c == 'I'

	mov $5, %rax
	ret                   # return 5


est_voyelle_if11:
	mov $'O', %rbx
	cmp %rax, %rbx
	jne est_voyelle_if12  # c == 'O'

	mov $6, %rax
	ret                   # return 6

est_voyelle_if12:
	xor %rax, %rax
	ret                   #   return 0
# }

# void afficher_occurence(int numero, char lettre)
afficher_occurence:
	mov %rsi, %rax
	movb %al, buffer           # 	buffer[0] = lettre

	mov $compteur, %rbx
	mov (%rbx, %rdi, 8), %rax
	push %rax
	call affiche_entier 
	pop %rax                     # affiche_entier(compteur[numero])


	mov $1, %rbx
	cmp %rax, %rbx
	jge affichage_if_else       # if (compteur[numero] > 1)

	mov $1, %rax
	mov $1, %rdi
	mov $message_occurences_de, %rsi
	mov $16, %rdx
	syscall                     #   write(stdout, message_occurences_de, 16)

	jmp affichage_if_fin

affichage_if_else:              # else

	mov $1, %rax
	mov $1, %rdi
	mov $message_occurence_de, %rsi
	mov $15, %rdx
	syscall                     #   write(stdout, message_occurence_de, 15)

affichage_if_fin:

	mov $1, %rax
	mov $1, %rdi
	mov $buffer, %rsi
	mov $2, %rdx
	syscall                     #   write(stdout, buffer, 2)

	ret

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
	je lecture_for_pas          #   if (c = est_voyelle(texte[i]))

	dec %rax
	mov $compteur, %rdx
	mov (%rdx, %rax, 8), %rbx
	inc %rbx
	mov %rbx, (%rdx, %rax, 8)   # compteur[--c]++

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

	xor %rdi, %rdi
	mov $'a', %rsi
	call afficher_occurence     # afficher_occurence(0, 'a')

	mov $1, %rdi
	mov $'e', %rsi
	call afficher_occurence     # afficher_occurence(1, 'e')

	mov $4, %rdi
	mov $'i', %rsi
	call afficher_occurence     # afficher_occurence(4, 'i')

	mov $5, %rdi
	mov $'o', %rsi
	call afficher_occurence     # afficher_occurence(5, 'o')

	mov $3, %rdi
	mov $'u', %rsi
	call afficher_occurence     # afficher_occurence(3, 'u')

	mov $2, %rdi
	mov $'y', %rsi
	call afficher_occurence     # afficher_occurence(2, 'y')

	mov $60, %rax				# exit(0)
	xor %rdi, %rdi
	syscall

