//
// Created on 2024/4/22.
//
// Node APIs are not fully supported. To solve the compilation error of the interface cannot be found,
// please include "napi/native_api.h".

#ifndef HM4DEMO_CALCULATOR_H
#define HM4DEMO_CALCULATOR_H

#include "Calculate.h"
#include "js_native_api.h"

class Calculator {
public:
    Calculator();
    ~Calculator();
    Calculate *_calculate;
};

Calculator *util_get_napi_info(napi_env env, napi_callback_info cbinfo, size_t argc, napi_value *argv);
Calculate *util_get_napi_calculate(napi_env env, napi_callback_info cbinfo, size_t argc, napi_value *argv);

int add(int a, int b);
CalculateInfo getInfo();


#endif //HM4DEMO_CALCULATOR_H
