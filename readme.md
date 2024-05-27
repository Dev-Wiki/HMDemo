本项目代码地址为: [Harmony/HM4Demo - HM4Demo - DevWiki Gitea](https://git.devwiki.net/Harmony/HM4Demo)

提交时会同步更新至:
- github: [Dev-Wiki/HM4Demo](https://github.com/Dev-Wiki/HM4Demo)
- gitee : [DevWiki/HM4Demo](https://gitee.com/devwiki/HM4Demo)

# 项目概要

## 重要说明

本项目为 HM4项目,其中:
- compileSdkVersion : 4.1.0(11)
- compatibleSdkVersion: 4.0.0(10)

请使用API对应的DevEco进行编译.

本项目模块分为:
- app: 主入口模块
- common_ui : 通用UI动态共享库模块
- base: 最底层的依赖库, 包含最通用的代码封装.
- cppLib: C++项目, 编译so提供给native_lib模块使用
- native_lib: 包含C++ 的 shared 模块


## app模块

- [MVVM架构](app/src/main/ets/pages/mvvm/HomePage.ets)

- [web功能](app/src/main/ets/pages/web)
- [布局学习](app/src/main/ets/pages/layout)
  - [线性布局](app/src/main/ets/pages/layout/LinearLayoutPage.ets)
- [动画](app/src/main/ets/pages/animation)
- [多媒体](app/src/main/ets/pages/media)
  - [AVPlayer](app/src/main/ets/pages/media/AVPlayerPage.ets)
  - [照片选择](app/src/main/ets/pages/media/PhotoPage.ets)

## common ui模块

包含的组件有:

- 封装: [WebView](common_ui/src/main/ets/component/web/WebView.ets)
- 自定标题栏: [TitleBar](common_ui/src/main/ets/component/TitleBar.ets)
- 公用资源调用类: [CommonRes](common_ui/src/main/ets/utils/CommonRes.ets)



## base 模块

事件相关:
- 事件发射器: [Emitter](base/src/main/ets/event/Emitter.ets)

工具类:
- 屏幕相关: [ScreenUtil](base/src/main/ets/utils/ScreenUtil.ets)
- 日志工具: [Log](base/src/main/ets/utils/Log.ets)
- 持久化存储: [BaseLocalStorage](base/src/main/ets/utils/BaseLocalStorage.ets)