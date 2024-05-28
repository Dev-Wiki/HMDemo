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

target_link_libraries(hmcalculate PUBLIC ${NATIVERENDER_ROOT_PATH}/../../../../cppLib/dist/lib/arm64-v8a/libcalculate.so)