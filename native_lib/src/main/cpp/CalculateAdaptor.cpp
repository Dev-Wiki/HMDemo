//
// Created on 2024/4/22.
//
// Node APIs are not fully supported. To solve the compilation error of the interface cannot be found,
// please include "napi/native_api.h".

#include "CalculateAdaptor.h"
#include "library.h"

CalculateAdaptor::CalculateAdaptor() { 
    _calculate = &Calculate::getInstance(); 
}

CalculateAdaptor::CalculateAdaptor(napi_env env, napi_value thisVar) { 
    _calculate = &Calculate::getInstance();
}

CalculateAdaptor::~CalculateAdaptor() {
    
}

CalculateAdaptor *util_get_napi_info(napi_env env, napi_callback_info cbinfo, size_t argc, napi_value *argv) 
{
    napi_value thisVar = nullptr;
    void *data = nullptr;
    napi_get_cb_info(env, cbinfo, &argc, argv, &thisVar, &data);
    CalculateAdaptor *calculator = nullptr;
    napi_unwrap(env, thisVar, (void **)&calculator);
    return calculator;
}


napi_value calculate_add(napi_env env, napi_callback_info info) {
    size_t argc = 2;
    napi_value argv[2] = {0};
    CalculateAdaptor *calculator = util_get_napi_info(env, info, argc, argv);

    int32_t result = 0;
    napi_status a = napi_ok;
    a = napi_get_value_int32(env, argv[0], &result);

    napi_status b = napi_ok;
    b = napi_get_value_int32(env, argv[1], &result);
    
    napi_value value;
    napi_create_int32(env, calculator->_calculate->add(a, b), &value);
    return value;
}

napi_value calculate_getInfo(napi_env env, napi_callback_info info) {
    size_t argc = 0;
    napi_value argv[1] = {0};
    CalculateAdaptor *calculator = util_get_napi_info(env, info, argc, argv);
    
    CalculateInfo info2;
    info2.name = calculator->_calculate->getInfo().name;
    info2.versionCode = calculator->_calculate->getInfo().versionCode;
    info2.versionName = calculator->_calculate->getInfo().versionName;
    
    napi_value value;
    
    return value;
}
