@echo off
chcp 65001 > nul
set native_path=D:\AppData\Huawei\Sdk\HarmonyOS-NEXT-DP2\base\native\
set toolchain=%native_path%build\cmake\ohos.toolchain.cmake
set cmake_root=%native_path%build-tools\cmake\
set cmake_path=%cmake_root%bin\cmake.exe
set ninja_path=%cmake_root%bin\ninja.exe
set make_path=C:\MinGW\msys\1.0\bin\make.exe
set arch=arm64-v8a

IF NOT "%~1"=="" (
    set arch=%1
)

if exist build (
    del /q /s build
) else (
    mkdir build
)

if exist dist (
    cd dist
    if exist "%arch%" (
        del /q /s ""%arch%"
    )
)

cd build
:: 使用 make 构建
:: %cmake_path% -G"Unix Makefiles" -DCMAKE_MAKE_PROGRAM="%make_path%" -DOHOS_STL=c++_static -DOHOS_ARCH="%arch%" -DOHOS_PLATFORM=OHOS -DCMAKE_TOOLCHAIN_FILE=%toolchain% ..
:: %make_path%

:: 使用 ninja 构建
%cmake_path% -GNinja -DCMAKE_MAKE_PROGRAM="%ninja_path%" -DOHOS_STL=c++_static -DOHOS_ARCH="%arch%" -DOHOS_PLATFORM=OHOS -DCMAKE_TOOLCHAIN_FILE=%toolchain% ..
%ninja_path%
cd ../

