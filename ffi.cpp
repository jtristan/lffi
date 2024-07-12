#include <lean/lean.h>
#include <cstdlib> 
#include <iostream> 
using namespace std; 

extern "C" uint32_t my_add(uint32_t a, uint32_t b) {
    cout << "From C: my_add\n";
    return a + b;
}

extern "C" lean_object * nat_to_string(lean_object * n);

//
//
//
//
//

extern "C" lean_object * create_real(lean_object * a) {
    cout << "From C: create_real " << "\n" << std::flush;
    return a;
}

extern "C" lean_object * my_print(lean_object * a) {
    cout << "From C: my_print\n" << std::flush;
    return nat_to_string(a);
}

extern "C" lean_object * my_add2(lean_object * a, lean_object * b) {
    cout << "From C: my_add2\n" << std::flush;
    return lean_nat_add(a,b);
}

//
//
//
//
//

extern "C" lean_object * create_real_fun(lean_object * a, lean_object * eta) {
    return a;
}

extern "C" lean_object * my_print_fun(lean_object * a) {
    lean_object * fin = lean_apply_1(a,0);
    return nat_to_string(fin);
}

extern "C" lean_object * my_add2_fun(lean_object * a, lean_object * b, lean_object * eta) {
    lean_object * ex1 = lean_apply_1(a,0);
    lean_object * ex2 = lean_apply_1(b,0);
    return lean_nat_add(ex1,ex2);
}

