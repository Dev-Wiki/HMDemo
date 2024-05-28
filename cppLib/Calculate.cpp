#include "Calculate.h"

#include <iostream>

Calculate& Calculate::getInstance() {
    // 使用静态局部变量确保线程安全地初始化单例对象
    static Calculate instance;
    return instance;
}

int Calculate::add(int a, int b) {
    return a + b;
}

CalculateInfo Calculate::getInfo() {
    CalculateInfo info;
    info.name = "Calculate";
    info.versionName = "Calculate_v1.0.0";
    info.versionCode = 1;
    return info;
}
