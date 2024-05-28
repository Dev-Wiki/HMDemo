#include "napi/native_api.h"
#include "CalculateAdaptor.h"
#include "js_native_api.h"

napi_value JS_Constructor(napi_env env, napi_callback_info info) {
    napi_value thisVar = nullptr;
    void *data = nullptr;
    napi_get_cb_info(env, info, nullptr, nullptr, &thisVar, &data);
    CalculateAdaptor *adaptor = new CalculateAdaptor(env, thisVar);
    napi_wrap(
        env, thisVar, adaptor,
        [](napi_env env, void *data, void *hint) {
            CalculateAdaptor *ada = (CalculateAdaptor *)data;
            delete ada;
        },
        nullptr, nullptr);

    return thisVar;
}

napi_value Init(napi_env env, napi_value exports)
{
    const char className[] = "CalculateAdaptor";
    napi_property_descriptor desc[] = {{"add", nullptr, calculate_add, nullptr, nullptr, nullptr, napi_default, nullptr},
                                       {"getInfo", nullptr, calculate_getInfo, nullptr, nullptr, nullptr, napi_default, nullptr}};
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);

    napi_value result = nullptr;
    napi_define_class(env, className, sizeof(className), JS_Constructor, nullptr,
                      sizeof(desc) / sizeof(desc[0]), desc, &result);

    napi_set_named_property(env, exports, "CalculateAdaptor", result);
    return exports;
}

static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "native_lib",
    .nm_priv = ((void*)0),
    .reserved = { 0 },
};

extern "C" __attribute__((constructor)) void RegisterNatvie_libModule(void)
{
    napi_module_register(&demoModule);
}
