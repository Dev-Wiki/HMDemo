//
// Created on 2024/5/28.
//
// Node APIs are not fully supported. To solve the compilation error of the interface cannot be found,
// please include "napi/native_api.h".

#ifndef HM4DEMO_CALCULATEINFO_H
#define HM4DEMO_CALCULATEINFO_H

#include <string>
struct CalculateInfo {
    std::string name;
    std::string versionName;
    int versionCode;
};

#endif //HM4DEMO_CALCULATEINFO_H
