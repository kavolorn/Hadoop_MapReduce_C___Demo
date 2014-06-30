#include <iostream>

#include "typedbytes.h"

using namespace std;

int main(int argc, char ** argv)
{
    TypedBytesInFile in(stdin);
    
    while (!feof(in.stream))
    {
        TypedBytesType keytype = in.next_type();
        if (keytype == TypedBytesTypeError) 
        {
            if (feof(in.stream)) {
                return 0;
            }
            else {
                fprintf(stderr, "!eof but typeerror=%i\n", in.lastcode);
                return 0;
            }
        }
        cout << in.read_int();
        cout << "\t";
        
        in.next_type();
        cout << in.read_double();
        cout << "\n";
    }
    
    return 0;
}