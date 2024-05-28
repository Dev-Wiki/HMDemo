import { CommonRes, TitleBar } from '@devwiki/common_ui';
import web_webview from '@ohos.web.webview';
import { TitleBarMenuType } from '@devwiki/common_ui';
import { router, window } from '@kit.ArkUI';
import promptAction from '@ohos.promptAction';
import { BusinessError } from '@ohos.base';
import { Log } from '@devwiki/base';
import { BaseLocalStorage, ScreenUtil } from '@devwiki/base';
import { HomeItem, HomeItemGroup } from '../model/Home';
import { CalculateAdapter } from '@devwiki/hmcalculate';


@Entry
@Component
struct Index {
  @State title: string = "Home";
  readonly itemGroups: HomeItemGroup[] = [
    //Web部分
    {
      name: 'Net',
      items: [
        { name: 'WebPage', page: 'pages/web/WebPage' },
        { name: 'WebDialogPage', page: 'pages/web/WebDialogPage' },
        { name: "TcpSocket", page: 'pages/net/TcpSocketPage'},
        { name: "RestAPI", page: 'pages/net/RestAPIPage'}
      ]
    },
    {
      name: 'Component',
      items: [
        {name: 'InputPage', page: 'pages/component/InputPage'}
      ]
    },
    // 布局
    {
      name: 'Layout',
      items: [
        { name: 'LinearLayout', page: 'pages/layout/LinearLayoutPage' },
        { name: 'RelativeContainer', page: 'pages/layout/RelativeContainerPage' },
      ]
    },
    //动画
    {
      name: "Animation",
      items: [
        { name: 'CompTransition', page: 'pages/animation/CompTransitionPage'},
      ]
    },
    // 多媒体
    {
      name: 'Multimedia',
      items: [
        { name: 'AVPlayer', page: 'pages/media/AVPlayerPage' },
      ]
    },
    //系统能力
    {
      name: 'System',
      items: [
        {name: "Scheme", page: 'pages/system/SchemePage'},
        {name: "MVVM", page: 'pages/mvvm/HomePage'}
      ]
    }
  ];

  adapter?: CalculateAdapter;

  aboutToAppear(): void {
    ScreenUtil.getInstance().initScreenSize();
    BaseLocalStorage.getInstance().init(getContext(this));
    this.adapter = new CalculateAdapter();
    let a = this.adapter.add(1,2);
  }

  onPageShow(): void {
    ScreenUtil.getInstance().setPreferredOrientation(window.Orientation.AUTO_ROTATION);
  }

  /**
   * 页面的进入 退出动画 router时生效
   */
  pageTransition() {
    // 定义页面进入时的效果，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ type: RouteType.None, duration: 100 }).opacity(1)
    // 定义页面退出时的效果，无论页面栈发生push还是pop操作均可生效
    PageTransitionExit({ type: RouteType.None, duration: 100 }).opacity(0)
  }

  /**
   * 拦截手势侧滑返回和标题栏的返回按钮, 增加弹窗提醒。
   * @returns
   */
  onBackPress(): boolean | void {
    // 弹出自定义的询问框
    promptAction.showDialog({
      message: '确定要退出吗？',
      buttons: [
        {
          text: '取消',
          color: '#FF0000'
        },
        {
          text: '确认',
          color: '#0099FF'
        }
      ]
    }).then((result: promptAction.ShowDialogSuccessResponse) => {
      if (result.index === 0) {
        // 用户点击了“取消”按钮
        Log.i('User canceled the operation.');
      } else if (result.index === 1) {
        // 用户点击了“确认”按钮
        Log.i('User confirmed the operation.');
        // 调用router.back()方法，返回上一个页面
        router.back();
      }
    }).catch((err: Error) => {
      let message = (err as BusinessError).message
      let code = (err as BusinessError).code
      Log.i(`Invoke showDialog failed, code is ${code}, message is ${message}`);
    })
    return true;
  }

  @Builder
  groupBuilder(group: HomeItemGroup) {
    Row(){
      if (group.icon) {
        Image(group.icon).width(24).height(24).margin({right: 8});
      }
      Text(group.name);
    }.height(32).width('100%').padding({left: 8, right: 8})
    .backgroundColor('#e0e0e0').alignItems(VerticalAlign.Center)
  }

  @Builder
  itemBuilder(item: HomeItem) {
    Column() {
      Row() {
        Text(item.name);
        Image(CommonRes.getImage(CommonRes.IC_CHEVRON_RIGHT)).width(32).height(32);
      }.width('100%').height(48).justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center)
      .padding({left: 16, right: 16})
      Divider().margin({ top: 2 });
    }.onClick(() => {
      if (item.page) {
        this.getUIContext().getRouter().pushUrl({url: item.page })
      }
    })
  }

  build() {
    Column() {
      TitleBar({
        title: this.title,
        onLeftClicked: () => {
          this.onBackPress()
        },
        rightMenuType: TitleBarMenuType.None
      }).width('100%')

      List(){
        ForEach(this.itemGroups, (group: HomeItemGroup) => {
          ListItemGroup({header: this.groupBuilder(group)}) {
            ForEach(group.items, (item: HomeItem) => {
              this.itemBuilder(item);
            })
          }
        })
      }.width('100%').margin({top: 16, bottom: 48})
    }.width('100%').height('100%')
  }
}