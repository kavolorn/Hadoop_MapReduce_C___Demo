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
        
        if (buffer.length() == 0) {
            break;
        }
        
        sin.str(buffer);
        sin.clear();

        sin >> i;
        out.write_int(i);

        out.write_vector_start(3);

        for (i = 0; i < 3; i++)
        {
            sin >> j;
            out.write_double(j);
        }
    }
    
    return 0;
}