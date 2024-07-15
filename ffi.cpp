#include <lean/lean.h>
#include <cstdlib> 
#include <iostream> 
#include <sys/time.h>
using namespace std; 

extern "C" lean_object * prob_UniformP2(lean_object * a, lean_object * eta) {
    if (lean_is_scalar(a)) {
        size_t n = lean_unbox(a);
        if (n == 0) {
            lean_internal_panic("prob_UniformP2: n == 0");
        } else {
            if (n < 10) {
                size_t bound = 1 << n; 
                size_t r = rand() % bound; 
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
    return a;
} 

extern "C" lean_object * prob_Bind(lean_object * f, lean_object * g, lean_object * eta) {
    lean_object * exf = lean_apply_1(f,0);
    lean_object * pa = lean_apply_2(g,exf,0);
    return pa;
} 

extern "C" lean_object * prob_While(lean_object * condition, lean_object * body, lean_object * init, lean_object * eta) {
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
    lean_object * comp = lean_apply_1(a,0);
    return lean_io_result_mk_ok(comp);
} 

extern "C" lean_object * into_IO(lean_object * a) {
    return lean_io_result_mk_ok(a);
}