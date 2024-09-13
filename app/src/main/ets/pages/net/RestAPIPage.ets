import { Log } from '@devwiki/base/Index';
import axios, { AxiosError, AxiosResponse } from '@ohos/axios'
import http from '@ohos.net.http';
import { RestAPI } from './RestAPI';
import { Organization } from './APIModel';
import { convertxml, util } from '@kit.ArkTS';

const TAG = '[RestAPIPage]'

@Entry({routeName: "RestAPIPage"})
@Component
struct RestAPIPage {

  @State viewModel: RestAPIViewModel = new RestAPIViewModel();

  build() {
    Column() {
      Flex({
        justifyContent: FlexAlign.Start,
        direction: FlexDirection.Column,
        alignItems: ItemAlign.Center
      }) {

        Refresh({
          refreshing: $$this.viewModel.refreshing,
        }){
          List(){
            ForEach(this.viewModel.orsg, (org: Organization, index: number) =>{
              ListItem(){
                Row() {
                  Image(org.avatar_url).width(36).height(36).objectFit(ImageFit.Contain)
                  Text(org.name)
                }.justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center).height(48)
              }
            })
          }.width('100%').height('100%').layoutWeight(1)
        }.pullToRefresh(true)
        .onRefreshing(() =>{
          this.viewModel.getAllOrgs();
        })

        Button("GetByHttp").onClick(() =>{
          this.viewModel.getServerVersionByHttp();
        }).margin({top: 20})
      }.width('80%')
    }.width('100%')
  }
}


class RestAPIViewModel {

  orsg: Organization[] = []
  refreshing: boolean = false;

  private restAPI: RestAPI = new RestAPI();

  getAllOrgs() {
    this.restAPI.getAllOrganizations((result) => {
      if (result.data) {
        this.orsg = result.data;
      }
      this.refreshing = false;
    })
  }

  getServerVersionByHttp() {
    let request = http.createHttp();
    let header: Map<string, string> = new Map();
    request.request('https://qt.gtimg.cn/q=s_sh000001', {
      header: {
        'Content-Type': 'text/html; charset=GBK'
      },
      expectDataType: http.HttpDataType.ARRAY_BUFFER
    }).then(res => {
      let data = this.gbkToUTF8(res.result as ArrayBuffer);
      Log.info(res.responseCode.toString());
    })
  }

  gbkToUTF8(content: ArrayBuffer): string {
    let textDecoderOptions: util.TextDecoderOptions = {
      fatal: false,
      ignoreBOM : true
    }
    let decodeWithStreamOptions: util.DecodeWithStreamOptions = {
      stream: true
    }
    let textDecoder = util.TextDecoder.create('gbk', textDecoderOptions);
    let retStr = textDecoder.decodeWithStream( new Uint8Array(content) , decodeWithStreamOptions);
    return retStr;
  }


}