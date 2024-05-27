import { Log } from '@devwiki/base/Index';
import axios, { AxiosError, AxiosResponse } from '@ohos/axios'

@Entry({routeName: "RestAPIPage"})
@Component
export struct RestAPIPage {

  @State viewModel: RestAPIViewModel = new RestAPIViewModel();

  build() {
    Row() {
      Flex({
        justifyContent: FlexAlign.SpaceBetween
      }) {
        Button("Get").onClick(() =>{
          this.viewModel.getServerVersion();
        })

        Text(this.viewModel.serverVersion).backgroundColor(Color.Blue).flexGrow(1);
      }
    }.justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center).width('80%').backgroundColor(Color.Green)
  }
}


class RestAPIViewModel {

  serverVersion: string = '123'

  async getServerVersion() {
    await axios({
      method: "post",
      url: 'https://music.devwiki.net/rest/ping.view?v=1.16.1&c=myapp&f=json'
    }).then((response: AxiosResponse) => {
      if (response.status == 200) {
        let version:string = response.data['subsonic-response']['serverVersion'];
        this.serverVersion = version;
        Log.i(`serverVersion: ${this.serverVersion}`)
      }
    }).catch((error: AxiosError) => {
      Log.e(error.message);
    })
  }
}