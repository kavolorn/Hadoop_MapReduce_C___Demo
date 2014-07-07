#include <iostream>

#include "typedbytes.h"

using namespace std;

int main(int argc, char ** argv)
{
    TypedBytesInFile in(stdin);
    TypedBytesType keytype;
    
    while (!feof(in.stream))
    {
        keytype = in.next_type();
        if (keytype == TypedBytesInteger) 
        {
            cout << in.read_int();
            cout << "\t";

            keytype = in.next_type();
            if (keytype == TypedBytesVector)
            {
                int vector_length = in.read_typedbytes_sequence_length();

                for (int j = 0; j < vector_length; j++)
                {
                    in.next_type();
                    cout << in.read_double() << ((j == vector_length - 1) ? "" : " ");
                }
                cout << "\n";
            }
        }
        else
        {
            return 0;
        }
    }
    
    return 0;
}