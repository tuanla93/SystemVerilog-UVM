#include <stdio.h>
#include <iostream>
//#include <cstdint>
#include <stdint.h>

using namespace std;

//#define MAIN_RUN

class sign_extend {
  public: 
  	long int ext (int input) {
      if ((input & 0x80000000) == 0) {
        //cout << "Pos Ext" << endl;
        return ( 0x0000000000000000 | input);
      } else {
        //cout << "Neg Ext" << endl;
        return ( 0xFFFFFFFF00000000 | input );
      }
  	}
};

#ifdef MAIN_RUN
int main(int argc, char** argv) {
  int sign;
  int arg_op1;
  int arg_op2;
  //cout << sizeof(long int) << endl;
  //int op = 0x7FFFFFFF;
  //cout << op << " - " << (long int)op + 0xFFFFFFFF << " - " << op + 0xFFFFFFFF << endl;
  //cout << argc << argv[0] << endl;
  if (argc == 4) {
    sign = atoi(argv[1]);
    arg_op1  = (int)atoi(argv[2]);
    arg_op2  = (int)atoi(argv[3]);
  } else {
    fprintf(stderr, "Input argument wrong! <sign> <operand1> <operand2>\n");
    exit(EXIT_FAILURE);
    return 0;
  }

#else
//int comp_32bs_cmodel (int sign, int arg_op1, int arg_op2) {
extern "C" int comp_32bs_cmodel (int sign, int arg_op1, int arg_op2) {
#endif
  
  int64_t op1, op2;
  
  // TODO: "long" type in here is 4 bytes! It should be 8 bytes. Therefore use stdint and int64_t
  //cout << "Size of :" << sizeof(op1) << endl;
  std::cout << std::showbase << std::hex;
  sign_extend sext;
  if (sign == 1) {
    op1 = sext.ext(arg_op1);
    op2 = sext.ext(arg_op2);
  } else {
    op1  = 0x00000000FFFFFFFF & arg_op1;
    op2  = 0x00000000FFFFFFFF & arg_op2;
  }
  cout << "SIGN = " << (int)sign << "; OP1 = " << op1 << "; OP2 = " << op2 << endl;
  //WRONG PRINT FORMAT printf("SIGN = %d ; OP1 = %09x ; OP2 = %09x \n", sign, arg_op1, arg_op2);
  //WRONG PRINT FORMAT printf("SIGN = %d ; OP1 = %09x ; OP2 = %09x \n", sign, op1, op2);
         
  char result; // ={eq, neq, grt, lss}
  if (op1 == op2)     { 
    result = 0x8;
    printf("===> [%d] Equal!\n", result);
    //cout << "===> Equal!" << endl;
  } else if (op1 < op2) {
    result = 0x5;
    printf("===> [%d] Less and Not Equal!\n", result);
    //cout << "===> Less and Not Equal!" << endl;
  } else { 
    result = 0x6;
    printf("===> [%d] Great and Not Equal!\n", result);
    //cout << "===> Great and Not Equal!" << endl;
  }
  //cout << "Output = " << (int)result << endl;
  return (int)result;
}
