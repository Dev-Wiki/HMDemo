# CMake 最低版本号要求
cmake_minimum_required(VERSION 3.5)

# 项目名称和版本
project(calculate)

# 设置编译标准
set(CMAKE_CXX_STANDARD 11)

# 设置生成静态库还是动态库
set(STATIC_OR_SHARED SHARED)

# 设置输出目录
IF(OHOS_ARCH STREQUAL "arm64-v8a")
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../dist/lib/arm64-v8a)
ELSEIF(OHOS_ARCH STREQUAL "x86_64")
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../dist/lib/x86_64)
ELSE()
    MESSAGE(FATAL_ERROR "Unsupported architecture: ${OHOS_ARCH}")
ENDIF()

# 添加共享库
add_library(${PROJECT_NAME} ${STATIC_OR_SHARED} library.cpp)

# 解析配置
if(EX_PLATFORM EQUAL 32)
    set(EX_PLATFORM_FLAG -m32)
elseif(EX_PLATFORM EQUAL 64)
    set(EX_PLATFORM_FLAG -m64)
else()
	message(WARNING "User defined ex_platform not 32 or 64 !")
endif()