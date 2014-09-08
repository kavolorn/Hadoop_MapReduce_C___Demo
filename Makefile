LIBTYPEDBYTESDIR=../libtypedbytes

.PHONY: compile clean run

compile: bin/mapper bin/reducer

bin/mapper:
	mkdir -p bin
	g++ -o $@ mapper.cpp \
	-I$(LIBTYPEDBYTESDIR) -L$(LIBTYPEDBYTESDIR) -ltypedbytes

bin/reducer:
	mkdir -p bin
	g++ -o $@ reducer.cpp \
	-I$(LIBTYPEDBYTESDIR) -L$(LIBTYPEDBYTESDIR) -ltypedbytes

clean:
	rm -rf bin output