import { Emitter, EmitterItem } from '@devwiki/base';
import { Toast } from '../../utils/Toast';

@Entry
@Component
export struct HomePage {

  @Provide tv1ViewModel: TabView1ViewModel = new TabView1ViewModel();
  @Provide tv2ViewModel: TabView2ViewModel = new TabView2ViewModel();

  aboutToAppear(): void {
    this.tv1ViewModel.onCountChanged = (count: number) => {
      Toast.showToast(`view1 count changed to:${count}`)
    }
    this.tv2ViewModel.onCountChanged = (count: number) => {
      Toast.showToast(`view2 count changed to:${count}`)
    }
  }

  onPageShow(): void {
    this.tv1ViewModel.onPageShow();
    this.tv2ViewModel.onPageShow();
  }

  onPageHide(): void {
    this.tv1ViewModel.onPageHide();
    this.tv2ViewModel.onPageHide();
  }

  build() {
    Tabs() {
      TabContent(){
        TabView1();
      }.tabBar("View1");
      TabContent() {
        TabView2();
      }.tabBar("View2")
    }.onChange((index) => {
      if (index == 0) {
        this.tv1ViewModel.onViewShow();
        this.tv2ViewModel.onViewHide();
      } else {
        this.tv1ViewModel.onViewHide();
        this.tv2ViewModel.onViewShow();
      }
    })
  }
}


@Component
struct TabView1 {
  @Consume tv1ViewModel: TabView1ViewModel;

  build() {
    Flex({
      justifyContent: FlexAlign.SpaceAround,
      alignItems: ItemAlign.Center,
      direction: FlexDirection.Column
    }){
      Scroll(){
        Text(this.tv1ViewModel.status);
      }

      Text(this.tv1ViewModel.count.toString())

      Row() {
        Button("Count").onClick(() =>{
          this.tv1ViewModel.onCountClicked();
        })

        Button("Send").onClick(() =>{
          this.tv1ViewModel.onSendClicked();
        })
      }
    }
  }
}

class TabView1ViewModel {
  count: number = 0
  status: string = 'view1';
  onCountChanged?: (count: number) => void;
  eventItem?: EmitterItem;

  subscribeEvent() {
    this.eventItem = Emitter.getInstance().on(TabViewKey.TabView2Message, (message: string) => {
      Toast.showToast(`view 1 reveive view 2 message:${message}}`)
    });
  }

  unsubscribeEvent() {
    if (this.eventItem) {
      Emitter.getInstance().off(this.eventItem)
    }
  }

  onCountClicked() {
    this.count++;
    this.onCountChanged?.(this.count);
  }

  onSendClicked() {
    Emitter.getInstance().emmit(TabViewKey.TabView1Message, 'tab view 1 message')
  }

  onPageShow() {
    this.status = this.status + "\nPageShow"
    this.subscribeEvent();
  }

  onPageHide() {
    this.unsubscribeEvent();
  }

  onViewShow() {
    this.status =  this.status + "\nView1Show"
  }

  onViewHide() {
    this.status =  this.status + "\nView1Hide"
  }
}

@Component
struct TabView2 {
  @Consume tv2ViewModel: TabView2ViewModel;

  build() {
    Flex({
      justifyContent: FlexAlign.SpaceAround,
      alignItems: ItemAlign.Center,
      direction: FlexDirection.Column
    }){
      Scroll(){
        Text(this.tv2ViewModel.status);
      }

      Text(this.tv2ViewModel.count.toString())

      Row() {
        Button("Count").onClick(() =>{
          this.tv2ViewModel.onCountClicked();
        })

        Button("Send").onClick(() =>{
          this.tv2ViewModel.onSendClicked();
        })
      }
    }
  }
}

class TabView2ViewModel {
  count: number = 0
  status: string = 'view2';
  onCountChanged?: (count: number) => void;
  eventItem?: EmitterItem;

  subscribeEvent() {
    this.eventItem = Emitter.getInstance().on(TabViewKey.TabView1Message, (message: string) => {
      Toast.showToast(`view2 reveive view 1 message:${message}}`)
    });
  }

  unsubscribeEvent() {
    if (this.eventItem) {
      Emitter.getInstance().off(this.eventItem)
    }
  }

  onCountClicked() {
    this.count++;
    this.onCountChanged?.(this.count);
  }

  onSendClicked() {
    Emitter.getInstance().emmit(TabViewKey.TabView2Message, 'tab view 2 message')
  }

  onPageShow() {
    this.status =  this.status + "\nPage2Show"
    this.subscribeEvent();
  }

  onPageHide() {
    this.unsubscribeEvent();
  }

  onViewShow() {
    this.status =  this.status + "\nView2Show"
  }
  onViewHide() {
    this.status =  this.status + "\nView2Hide"
  }
}


export class TabViewKey {
  public static readonly TabView1Message: string = "tab_view1_message";
  public static readonly TabView2Message: string = "tab_view2_message";
}