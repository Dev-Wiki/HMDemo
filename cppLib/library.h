#ifndef CPPLIB_LIBRARY_H
#define CPPLIB_LIBRARY_H

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

    // 删除拷贝构造函数和赋值运算符
    Calculate(const Calculate&) = delete;
    Calculate& operator=(const Calculate&) = delete;

private:
    // 构造函数和析构函数私有化
    Calculate() {}
    ~Calculate() {}
};
#endif //CPPLIB_LIBRARY_H



