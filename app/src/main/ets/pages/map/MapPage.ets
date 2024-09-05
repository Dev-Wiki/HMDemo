import { abilityAccessCtrl, bundleManager, common, PermissionRequestResult } from '@kit.AbilityKit';
import { geoLocationManager } from '@kit.LocationKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Component
@Entry({routeName: 'MapPage'})
struct MapPage {
  @State isShowLocationPopup: boolean = false
  appName: string = ''
  @State isLocationPermission: boolean = false;
  @State locText: string = ''

  checkLocationPermission() {
    let manager = abilityAccessCtrl.createAtManager() // 得到manager对象
    let appInfo =
      bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION) // 获取应用信息
    this.appName = appInfo.name;
    let context: Context = getContext(this) as common.UIAbilityContext;
    let permission:string = 'ohos.permission.LOCATION'
    let status = manager.checkAccessTokenSync(appInfo.appInfo.accessTokenId, "ohos.permission.LOCATION")
    if (status === abilityAccessCtrl.GrantStatus.PERMISSION_DENIED) {
      this.isShowLocationPopup = true;
      manager.requestPermissionsFromUser(context, ['ohos.permission.LOCATION'], (err: BusinessError, data: PermissionRequestResult) => {

      });
    } else {
      this.getLocationAddress();
    }
  }

  requestionLocationPermission() {

  }

  @Builder
  locationViewBuilder() {
    Row() {
      Text('开启定位权限，为您推荐附近商家与好物  ').fontSize(15);
      Button('去开启')
        .type(ButtonType.Normal)
        .height(24)
        .borderRadius(12)
        .width(60)
        .backgroundColor(Color.Red)
        .onClick(() => {
          if (this.isLocationPermission) {
            this.checkLocationPermission()
          }
        })

      SymbolGlyph($r('sys.symbol.xmark')).width(24).height(24).borderRadius(12).onClick(() => {
        this.isShowLocationPopup = false;
      })
    }
    .height(40)
    .alignItems(VerticalAlign.Center)
    .padding(5)
    .position({ x: 7, y: 50 })
    .zIndex(999)
    .backgroundColor('#123333')
    .borderRadius(10)
    .opacity(0.7)
  }

  build() {

    Column(){
      if (this.isShowLocationPopup) {
        this.locationViewBuilder();
      }
      Text(this.locText);
    }.width('100%').height('100%')
  }

  aboutToAppear(): void {
    this.checkLocationPermission()
  }

  getLocationAddress() {
    let reverseGeocodeRequest:geoLocationManager.ReverseGeoCodeRequest = {"latitude": 31.12, "longitude": 121.11, "maxItems": 1};
    try {
      geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest, (err, data) => {
        if (err) {
          console.error('getAddressesFromLocation: err=' + JSON.stringify(err));
        }
        if (data) {
          console.log('getAddressesFromLocation: data=' + JSON.stringify(data));
          this.locText = data[0].placeName ?? '';
        }
      });
    } catch (err) {
      console.error("errCode:" + JSON.stringify(err));
    }
  }
}