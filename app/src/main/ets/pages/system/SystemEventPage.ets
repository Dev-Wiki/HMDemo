import commonEventManager from '@ohos.commonEventManager';
import Base from '@ohos.base';


@Component
@Entry
export struct SystemEventPage {
  // 用于保存创建成功的订阅者对象，后续使用其完成订阅及退订的动作
  subscriber: commonEventManager.CommonEventSubscriber | null = null;
  // 订阅者信息
  subscribeInfo: commonEventManager.CommonEventSubscribeInfo = {
    events: ["usual.event.SCREEN_OFF"], // 订阅灭屏公共事件
  }

  aboutToAppear(): void {
    // 创建订阅者回调
    commonEventManager.createSubscriber(this.subscribeInfo, (err: Base.BusinessError, data: commonEventManager.CommonEventSubscriber) => {
      if (err) {
        console.error(`Failed to create subscriber. Code is ${err.code}, message is ${err.message}`);
        return;
      }
      console.info('Succeeded in creating subscriber.');
      this.subscriber = data;
      // 订阅公共事件回调
    })

    // 订阅公共事件回调
    if (this.subscriber !== null) {
      commonEventManager.subscribe(this.subscriber, (err: Base.BusinessError, data: commonEventManager.CommonEventData) => {
        if (err) {
          console.error(`Failed to subscribe common event. Code is ${err.code}, message is ${err.message}`);
          return;
        }
      })
    } else {
      console.error(`Need create subscriber`);
    }
  }

  build() {
  }
}