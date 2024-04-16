# 项目概要

本项目模块分为:
- app: 主入口模块
- common_ui : 通用UI动态共享库模块


## app模块

- [web功能](app/src/main/ets/pages/web)
- [布局学习](app/src/main/ets/pages/layout)
  - [线性布局](app/src/main/ets/pages/layout/LinearLayoutPage.ets)

## common ui模块

包含的组件有:

- 封装[WebView](common_ui/src/main/ets/component/web/WebView.ets)
- 自定标题栏: [TitleBar](common_ui/src/main/ets/component/TitleBar.ets)

事件相关:
- 事件发射器 [Emitter](common_ui/src/main/ets/event/Emitter.ets)

工具类:
- 公用资源调用类[CommonRes](common_ui/src/main/ets/utils/CommonRes.ets)
- 屏幕相关[ScreenUtil](common_ui/src/main/ets/utils/ScreenUtil.ets)