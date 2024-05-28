//
// Created on 2024/4/22.
//
// Node APIs are not fully supported. To solve the compilation error of the interface cannot be found,
// please include "napi/native_api.h".

#ifndef HM4DEMO_CALCULATOR_H
#define HM4DEMO_CALCULATOR_H

#include "CalculateInfo.h"
#include "Calculate.h"
#include "js_native_api.h"

class CalculateAdaptor {
public:
    CalculateAdaptor();
    CalculateAdaptor(napi_env env, napi_value thisVar);
    ~CalculateAdaptor();
    Calculate *_calculate;
};

CalculateAdaptor *util_get_napi_info(napi_env env, napi_callback_info cbinfo, size_t argc, napi_value *argv);

napi_value calculate_add(napi_env env, napi_callback_info info);
napi_value calculate_getInfo(napi_env env, napi_callback_info info);


#endif //HM4DEMO_CALCULATOR_H
