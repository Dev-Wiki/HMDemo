//
// Created on 2024/4/22.
//
// Node APIs are not fully supported. To solve the compilation error of the interface cannot be found,
// please include "napi/native_api.h".

#include "CalculateAdaptor.h"
#include "js_native_api.h"
#include "Calculate.h"
#include <string>
#include <stdint.h>

CalculateAdaptor::CalculateAdaptor() { 
}

CalculateAdaptor::CalculateAdaptor(napi_env env, napi_value thisVar) { 
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
    
    napi_value js_frame;
    napi_create_object(env, &js_frame);
    util_set_object_string_property_value(env, js_frame, "name", info2.name);
    util_set_object_string_property_value(env, js_frame, "versionName", &info2.versionName);
    util_set_object_int32_property_value(env, js_frame, "versionCode", info2.versionCode);
    
    return js_frame;
}

napi_value util_create_int32_value(napi_env env, int32_t arg)
{
    napi_value value;
    napi_status status = napi_create_int32(env, arg, &value);
    return value;
}

napi_status util_set_object_int32_property_value(napi_env env, napi_value object, const char *name, int32_t value)
{
    napi_value js_value = util_create_int32_value(env, value);
    return napi_set_named_property(env, object, name, js_value);
}

napi_value util_create_string_value(napi_env env, const char *arg)
{
    napi_value value;
    napi_status status = napi_create_string_utf8(env, arg, NAPI_AUTO_LENGTH, &value);
    return value;
}

napi_status util_set_object_string_property_value(napi_env env, napi_value object, const char *name, const char *value)
{
    napi_value js_value = util_create_string_value(env, value);
    return napi_set_named_property(env, object, name, js_value);
}

char *util_get_object_string_property_value(napi_env env, napi_value arg, const char *name)
{
    napi_status status = napi_ok;
    napi_value js_result;
    status = napi_get_named_property(env, arg, name, &js_result);
    if (napi_ok == status) {
        return util_get_string_value(env, js_result);
    }
    return "";
}

char *util_get_string_value(napi_env env, napi_value arg)
{
    size_t len = 0;
    napi_get_value_string_utf8(env, arg, nullptr, 0, &len);   // 获取字符串长度到len
    char *buf = new char[len + 1];                            // 分配合适大小的char数组
    napi_get_value_string_utf8(env, arg, buf, len + 1, &len); // 获取字符串
    return buf;
}
