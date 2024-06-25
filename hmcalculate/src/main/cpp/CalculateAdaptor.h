//
// Created on 2024/4/22.
//
// Node APIs are not fully supported. To solve the compilation error of the interface cannot be found,
// please include "napi/native_api.h".

#ifndef HM4DEMO_CALCULATOR_H
#define HM4DEMO_CALCULATOR_H

#include "Calculate.h"
#include "js_native_api.h"
#include <stdint.h>

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

napi_value util_create_int32_value(napi_env env, int32_t arg);
napi_status util_set_object_int32_property_value(napi_env env, napi_value object, const char *name, int32_t value);

napi_value util_create_string_value(napi_env env, const char *arg);
napi_status util_set_object_string_property_value(napi_env env, napi_value object, const char *name, const char *value);
char *util_get_object_string_property_value(napi_env env, napi_value arg, const char *name);
char *util_get_string_value(napi_env env, napi_value arg);

#endif //HM4DEMO_CALCULATOR_H
