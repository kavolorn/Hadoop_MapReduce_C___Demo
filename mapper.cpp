#include <iostream>
#include <sstream>
#include "typedbytes.h"

using namespace std;

int main(int argc, char ** argv)
{
    TypedBytesOutFile out(stdout);
    
    string buffer;
    istringstream sin;
    
    int i;
    double j;
    
    while (!cin.eof())
    {
        getline(cin, buffer);
        
        sin.str(buffer);
        sin.clear();
        
        sin >> i >> j;
        
        out.write_int(i);
        out.write_double(j);
    }
    
    return 0;
}