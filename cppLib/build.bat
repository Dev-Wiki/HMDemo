@echo off
chcp 65001 > nul

set "native_path=C:\Program Files\Huawei\DevEco Studio5\sdk\HarmonyOS-NEXT-DB1\openharmony\native\"
:: IF NOT "%~2" == "" (
::     set "native_path=%~2"
:: )
echo native_path: "%native_path%"

set "toolchain=%native_path%build\cmake\ohos.toolchain.cmake"
echo toolchain: "%toolchain%"
set "cmake_root=%native_path%build-tools\cmake\"
echo cmake_root: "%cmake_root%"
set "cmake_path=%cmake_root%bin\cmake.exe"
echo cmake_path: "%cmake_path%"
set "ninja_path=%cmake_root%bin\ninja.exe"
echo ninja_path: "%ninja_path%"
set "make_path=C:\MinGW\msys\1.0\bin\make.exe"
echo make_path: %make_path%
set "arch=arm64-v8a"

IF NOT "%~1" == "" (
    set "arch=%~1"
)
echo arch: "%arch%"

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
    cd ../
)

cd build
:: 使用 make 构建
:: "%cmake_path%" -G "Unix Makefiles" -DCMAKE_MAKE_PROGRAM="%make_path%" -DOHOS_STL=c++_static -DOHOS_ARCH="%arch%" -DOHOS_PLATFORM=OHOS -DCMAKE_TOOLCHAIN_FILE="%toolchain%" ..
:: %make_path%

:: 使用 ninja 构建
"%cmake_path%" -G "Ninja" -D CMAKE_MAKE_PROGRAM="%ninja_path%" -D OHOS_STL=c++_static -D OHOS_ARCH="%arch%" -D OHOS_PLATFORM=OHOS -D CMAKE_TOOLCHAIN_FILE="%toolchain%" ..
"%ninja_path%"
cd ../
