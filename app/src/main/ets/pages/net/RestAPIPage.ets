import { Log } from '@devwiki/base/Index';
import axios, { AxiosError, AxiosResponse } from '@ohos/axios'
import http from '@ohos.net.http';
import { RestAPI } from './RestAPI';
import { Organization } from './APIModel';

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
          this.viewModel.getAllOrgs();
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
  }
}