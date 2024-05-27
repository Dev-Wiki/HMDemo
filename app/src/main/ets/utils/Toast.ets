import promptAction from '@ohos.promptAction';

export class Toast {
  static showToast(message: ResourceStr) {
    promptAction.showToast({
      message: message,
      duration: 2000,
      bottom: "50%"
    });
  }
}