本项目代码地址为: [Harmony/HMDemo - HMDemo - DevWiki Gitea](https://git.devwiki.net/Harmony/HMDemo)

提交时会同步更新至:
- github: [Dev-Wiki/HMDemo](https://github.com/Dev-Wiki/HMDemo)
- gitee : [DevWiki/HMDemo](https://gitee.com/devwiki/HMDemo)

[TOC]

# 项目概要

## 1. 重要说明

目前分支如下:
### 1.1 master分支

基于API11,即 DevEco使用 4.x或者 5.0.3.200版本
- compileSdkVersion : 4.1.0(11)
- compatibleSdkVersion: 4.0.0(10)

### 1.2 api12分支
基于API12, DevEco使用 5.0.3.300之后版本

请使用API对应的DevEco进行编译.

### 1.3项目模块

本项目模块分为:
- app: 主入口模块
- common_ui : 通用UI动态共享库模块
- base: 最底层的依赖库, 包含最通用的代码封装.
- cppLib: C++项目, 编译so提供给native_lib模块使用
- native_lib: 包含C++ 的 shared 模块


## 2. app模块

- [动画](app/src/main/ets/pages/animation)
- [组件](app/src/main/ets/pages/component)
- [布局学习](app/src/main/ets/pages/layout)
  - [线性布局](app/src/main/ets/pages/layout/LinearLayoutPage.ets)
- [多媒体](app/src/main/ets/pages/media)
  - [AVPlayer](app/src/main/ets/pages/media/AVPlayerPage.ets)
  - [照片选择](app/src/main/ets/pages/media/PhotoPage.ets)
- [MVVM架构](app/src/main/ets/pages/mvvm/HomePage.ets)
- [网络](app/src/main/ets/pages/net)
- [系统功能](app/src/main/ets/pages/system)
- [web功能](app/src/main/ets/pages/web)

## 3. common ui模块

包含的组件有:

- 封装: [WebView](common_ui/src/main/ets/component/web/WebView.ets)
- 自定标题栏: [TitleBar](common_ui/src/main/ets/component/TitleBar.ets)
- 公用资源调用类: [CommonRes](common_ui/src/main/ets/utils/CommonRes.ets)



## 4. base 模块

事件相关:
- 事件发射器: [Emitter](base/src/main/ets/event/Emitter.ets)

工具类:
- 屏幕相关: [ScreenUtil](base/src/main/ets/utils/ScreenUtil.ets)
- 日志工具: [Log](base/src/main/ets/utils/Log.ets)
- 持久化存储: [BaseLocalStorage](base/src/main/ets/utils/BaseLocalStorage.ets)