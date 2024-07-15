#include <lean/lean.h>
#include <cstdlib> 
#include <iostream> 
#include <sys/time.h>
using namespace std; 

extern "C" lean_object * prob_UniformP2(lean_object * a, lean_object * eta) {
    if (lean_is_scalar(a)) {
        size_t n = lean_unbox(a);
        cout << "requested power of 2: " << n << "\n" << flush;
        if (n == 0) {
            lean_internal_panic("prob_UniformP2: n == 0");
        } else {
            if (n < 10) {
                size_t bound = 1 << n; 
                cout << "bound: " << bound << "\n" << flush;
                size_t r = rand() % bound; 
                cout << "random value: " << r << "\n" << flush;
                return lean_box(r);
            } else {
                lean_internal_panic("prob_UniformP2: not handling large values yet");
            }
        }
    } else {
        lean_internal_panic("prob_UniformP2: not handling very large values yet");
    }
}

extern "C" lean_object * prob_Pure(lean_object * a, lean_object * eta) {
    cout << "Return\n" << flush;
    return a;
} 

extern "C" lean_object * prob_Bind(lean_object * f, lean_object * g, lean_object * eta) {
    cout << "Bind\n" << flush;
    lean_object * exf = lean_apply_1(f,0);
    cout << "First value: " << lean_unbox(exf) << "\n" << flush;
    lean_object * pa = lean_apply_2(g,exf,0);
    cout << "Second value: " << lean_unbox(pa) << "\n" << flush;
    return pa;
} 

extern "C" lean_object * prob_While(lean_object * condition, lean_object * body, lean_object * init, lean_object * eta) {
    cout << "While\n" << flush;
    lean_object * state = init; 
    while (lean_unbox(lean_apply_1(condition,state))) {
        state = lean_apply_2(body,state,0);
    }
    return state;
}

extern "C" lean_object * my_run(lean_object * a) {
    struct timeval t1;
    gettimeofday(&t1, NULL);
    srand(t1.tv_usec * t1.tv_sec);
    cout << "my_run\n" << flush;
    lean_object * comp = lean_apply_1(a,0);
    cout << "into value: " << lean_unbox(comp) << "\n" << flush;
    return lean_io_result_mk_ok(comp);
} 

extern "C" lean_object * into_IO(lean_object * a) {
    return lean_io_result_mk_ok(a);
}