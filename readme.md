# 项目概要

本项目模块分为:
- app: 主入口模块
- common_ui : 通用UI动态共享库模块
- base: 最底层的依赖库, 包含最通用的代码封装.
- cppLib: C++项目, 编译so提供给native_lib模块使用
- native_lib: 包含C++ 的 shared 模块


## app模块

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