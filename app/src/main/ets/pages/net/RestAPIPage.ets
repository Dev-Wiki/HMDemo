import { Log } from '@devwiki/base/Index';
import axios, { AxiosError, AxiosResponse } from '@ohos/axios'
import http from '@ohos.net.http';

const TAG = '[RestAPIPage]'

@Entry({routeName: "RestAPIPage"})
@Component
export struct RestAPIPage {

  @State viewModel: RestAPIViewModel = new RestAPIViewModel();

  build() {
    Column() {
      Flex({
        justifyContent: FlexAlign.Start,
        direction: FlexDirection.Column,
        alignItems: ItemAlign.Center
      }) {
        Button("GetByAxios").onClick(() =>{
          this.viewModel.getServerVersionByAxios();
        }).margin({top: 20})

        Button("GetByHttp").onClick(() =>{
          this.viewModel.getServerVersionByHttp();
        }).margin({top: 20})

        Text(this.viewModel.serverVersion).margin({top: 20})
      }.width('80%')
    }.width('100%')
  }
}


class RestAPIViewModel {

  readonly viewUrl: string = 'https://music.devwiki.net/rest/ping.view?v=1.16.1&c=myapp&f=json';
  serverVersion: string = '123'

  async getServerVersionByAxios() {
    this.serverVersion = ''
    await axios({
      method: "post",
      url: this.viewUrl
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

  getServerVersionByHttp() {
    this.serverVersion = ''
    let httpRequest = http.createHttp();
    let option:http.HttpRequestOptions = {
      method: http.RequestMethod.GET
    };
    httpRequest.request(this.viewUrl, option, (error, resp) =>{
      if (!error) {
        Log.i(TAG, 'request http code:' + resp.responseCode)
        let version:string = resp.result['subsonic-response']['serverVersion'];
        this.serverVersion = version;
      } else {
        Log.e(TAG, `request failed, code:${error.code}, message:${error.message}`)
      }
      httpRequest.destroy();
    });
  }
}