compile: mapper reducer
	
mapper:
	mkdir -p bin
	g++ -o bin/$@ mapper.cpp
	
reducer:
	mkdir -p bin
	g++ -o bin/$@ reducer.cpp
	
clean:
	rm -rf bin output
	
run: compile
	cat input | bin/mapper | bin/reducer >> output