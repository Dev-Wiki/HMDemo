import { CommonRes } from '../utils/CommonRes';

@Extend(TextInput)
function textInputStyle() {
  .fontSize(15)
  .height(45)
  .backgroundColor(Color.White)
  .padding(5)
}

@Preview
@Component
export struct PhoneInput {
  @Prop countryCode: string = "+86"
  onCountryCodeClick?: () => void;
  @State inputText: string = ''
  onInputChanged?: (value: string) => void;
  @State isClearVisible: boolean = false;

  build() {
    Flex({
      justifyContent: FlexAlign.SpaceBetween,
      alignItems: ItemAlign.Center,
    }) {
      // 国家码
      Row() {
        Text(this.countryCode)
          .height(44)
        Image($r(`app.media.ic_chevron_down`))
          .objectFit(ImageFit.Contain)
          .width(12)
          .height(12)
          .backgroundColor(Color.Red)
          .margin({
            left: 2,
            right: 24
          })
      }.backgroundColor(Color.Green).width('')
      .onClick(() => {
        this.onCountryCodeClick?.();
      })

      // 账号输入框
      TextInput({ placeholder: "请输入号码", text: this.inputText })
        .maxLength(20)
        .type(InputType.Normal)
        .textInputStyle()
        .onChange((value: string) => {
          if (value) {
            this.isClearVisible = value.length > 0;
          } else {
            this.isClearVisible = false;
          }
          this.onInputChanged?.(value);
        })
        .width('100%')

      Image($r(`app.media.ic_clear_circle`))
        .width(18)
        .height(18)
        .backgroundColor(Color.Green)
        .colorBlend('#e1e2e5').objectFit(ImageFit.Contain)
        .onClick(() => {
          this.inputText = ''
        }).visibility(this.isClearVisible ? Visibility.Visible : Visibility.None)
    }
  }
}