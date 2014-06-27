.PHONY: compile clean run

compile: bin/mapper bin/reducer

bin/mapper:
	mkdir -p bin
	g++ -o $@ mapper.cpp

bin/reducer:
	mkdir -p bin
	g++ -o $@ reducer.cpp

clean:
	rm -rf bin output

run: compile
	cat input | bin/mapper | bin/reducer >> output
	cat output
