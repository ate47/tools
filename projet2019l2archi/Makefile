
CC=as
LD=ld
CFLAGS= --gstabs

SOURCES=compte_voyelles1.s compte_voyelles2.s compte_voyelles3.s compte_voyelles4.s
EXEC=$(patsubst %.s, %, $(SOURCES))
OBJECTS=$(patsubst %.s, %.o, $(SOURCES)) affiche_entier.o

all: $(EXEC)

debug: CFLAGS += -a
debug: $(EXEC)

%: %.s affiche_entier.o
	$(CC) $(CFLAGS) $@.s -o $@.o
	$(LD) $@.o affiche_entier.o -o $@

affiche_entier.o: affiche_entier.s
	$(CC) $(CFLAGS) affiche_entier.s -o affiche_entier.o

clean:
	-rm -f $(EXEC) $(OBJECTS)