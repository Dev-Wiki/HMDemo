# the minimum version of CMake.
cmake_minimum_required(VERSION 3.4.1)
project(hmcalculate)

set(NATIVERENDER_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})

if(DEFINED PACKAGE_FIND_FILE)
    include(${PACKAGE_FIND_FILE})
endif()

include_directories(${NATIVERENDER_ROOT_PATH}
                    ${NATIVERENDER_ROOT_PATH}/include)

add_library(hmcalculate SHARED
    napi_init.cpp
    CalculateInfo.h
    CalculateAdaptor.cpp)

# 根据不同的架构选择不同的库文件路径
IF(OHOS_ARCH STREQUAL "arm64-v8a")
    set(LIB_DIR ${NATIVERENDER_ROOT_PATH}/../../../../cppLib/dist/lib/arm64-v8a)
ELSEIF(OHOS_ARCH STREQUAL "x86_64")
    set(LIB_DIR ${NATIVERENDER_ROOT_PATH}/../../../../cppLib/dist/lib/x86_64)
ELSE()
    MESSAGE(FATAL_ERROR "Unsupported architecture: ${OHOS_ARCH}")
ENDIF()

target_link_libraries(hmcalculate PUBLIC ${LIB_DIR}/libcalculate.so)