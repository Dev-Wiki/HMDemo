import promptAction from '@ohos.promptAction';

export class Toast {
  static showToast(message: ResourceStr, topmost: boolean = false) {
    promptAction.showToast({
      message: message,
      duration: 2000,
      bottom: "50%",
      showMode: promptAction.ToastShowMode.TOP_MOST
    });
  }
}