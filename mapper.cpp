#include <iostream>
#include <sstream>
#include "typedbytes.h"

using namespace std;

int main(int argc, char ** argv)
{
    TypedBytesInFile in(stdin);
    TypedBytesOutFile out(stdout);
    TypedBytesType keytype;
    
    int i;
    double j;
    
    while (!feof(in.stream))
    {
        keytype = in.next_type();
        if (keytype == TypedBytesInteger) 
        {
            i = in.read_int();
            out.write_int(i);

            keytype = in.next_type();
            if (keytype == TypedBytesVector)
            {
                int vector_length = in.read_typedbytes_sequence_length();
                out.write_vector_start(vector_length);
                
                for (int k = 0; k < vector_length; k++)
                {
                    in.next_type();
                    j = in.read_double();
                    out.write_double(j);
                }
            }
        }
        else
        {
            return 0;
        }
    }
    
    return 0;
}