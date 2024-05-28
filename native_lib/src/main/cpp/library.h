//
// Created on 2024/4/22.
//
// Node APIs are not fully supported. To solve the compilation error of the interface cannot be found,
// please include "napi/native_api.h".

#ifndef HM4DEMO_CALCULATE_H
#define HM4DEMO_CALCULATE_H

#include <string>
struct CalculateInfo {
    std::string name;
    std::string versionName;
    int versionCode;
};

class Calculate {
public:
    static Calculate& getInstance();
    int add(int a, int b);
    CalculateInfo getInfo();
};
#endif //HM4DEMO_CALCULATE_H
