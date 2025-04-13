all: revGOL gol revGOL-mpi

CC:=gcc
EXT:=c
FLAGS:= -lm -lpng
MPICC:=mpicc

reverseGOL.o: reverseGOL.$(EXT)
	$(CC) $(FLAGS) -c reverseGOL.$(EXT)

reverseGOL-mpi.o: reverseGOL-mpi.$(EXT)
	$(MPICC) $(FLAGS) -c reverseGOL-mpi.$(EXT)

png_util.o: png_util.c
	$(CC) $(FLAGS) -c png_util.c

revGOL: reverseGOL.o png_util.o
	$(CC) $(FLAGS) -o revGOL reverseGOL.o png_util.o

revGOL-mpi: reverseGOL-mpi.o png_util.o
	$(MPICC) $(FLAGS) -o revGOL-mpi reverseGOL-mpi.o png_util.o

gameoflife.o: gameoflife.$(EXT)
	$(CC) $(FLAGS) -c gameoflife.$(EXT)

gol: gameoflife.o png_util.o
	$(CC) $(FLAGS) -o gol gameoflife.o png_util.o

test: revGOL data.txt
	./revGOL data.txt

clean:
	rm -f *.o
	rm -f gol revGOL revGOL-mpi
