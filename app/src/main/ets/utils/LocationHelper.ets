import { abilityAccessCtrl, bundleManager, common, PermissionRequestResult, Permissions } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { geoLocationManager } from '@kit.LocationKit';

const locationPermission: Permissions[] = ['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION'];

export class LocationHelper {

  appInfo: bundleManager.BundleInfo;
  context: common.UIAbilityContext;
  atManager: abilityAccessCtrl.AtManager;

  constructor(context: common.UIAbilityContext) {
    this.context = context;
    this.atManager = abilityAccessCtrl.createAtManager();
    this.appInfo = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION) // 获取应用信息
  }

  checkLocationPermission(callback: (isAllow: boolean) => void) {
    let status = this.atManager.checkAccessTokenSync(this.appInfo.appInfo.accessTokenId, locationPermission[0])
    callback(status === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED)
  }

  gotoSystemSetting() {

  }

  // openLocation(callback:(address: string) => void) {
  //   let options: AMapLocationOption = {
  //     priority: geoLocationManager.LocationRequestPriority.FIRST_FIX, //定位优先配置选项
  //     scenario: geoLocationManager.LocationRequestScenario.UNSET, //定位场景设置
  //     timeInterval: 2, //定位时间间隔
  //     distanceInterval: 0, //位置报告距离间隔
  //     maxAccuracy: 0, //定位精度 单位：米
  //     allowsBackgroundLocationUpdates: false, //是否允许后台定位
  //     locatingWithReGeocode: true, //定位是否返回逆地理信息
  //     reGeocodeLanguage: AMapLocationReGeocodeLanguage.Chinese, //逆地址语言类型
  //     isOffset: true //是否加偏
  //   }
  //   let listener: IAMapLocationListener = {
  //     onLocationChanged: (location) => {
  //       this.getLocationAddress(location.latitude,  location.longitude, 1, (err, data) => {
  //           if (err) {
  //             console.error('getAddressesFromLocation: err=' + JSON.stringify(err));
  //           }
  //           if (data) {
  //             console.log('getAddressesFromLocation: data=' + JSON.stringify(data));
  //             let loc = data[0].placeName ?? '';
  //             if (data[0].administrativeArea) {
  //               loc = loc.replace(data[0].administrativeArea, '')
  //             }
  //             if (data[0].subAdministrativeArea) {
  //               loc = loc.replace(data[0].subAdministrativeArea, '')
  //             }
  //             if (data[0].subLocality) {
  //               loc = loc.replace(data[0].subLocality, '')
  //             }
  //             if (data[0].roadName) {
  //               loc = loc.replace(data[0].roadName, '')
  //             }
  //             if (data[0].subRoadName) {
  //               loc = loc.replace(data[0].subRoadName, '')
  //             }
  //             if (data[0].subRoadName && loc === '') {
  //               loc = data[0].subRoadName?.toString()
  //             }
  //             callback(loc);
  //           }
  //         });
  //     }, onLocationError: (error) => {
  //       console.error(`IAMapLocationListener ${error.errorMsg}:${error.errorCode}`)
  //     }
  //   };
  //   this.locationManger?.setLocationListener(AMapLocationType.Updating, listener) //设置定位信息监听
  //   this.locationManger?.setLocationOption(AMapLocationType.Updating, options) //设置定位配置项
  //   this.locationManger?.startUpdatingLocation() //开启连续定位
  // }


  /**
   * 请求定位 allowScope是否允许定位, allowPrecision: 是否允许获取精确位置
   * @param callback
   */
  requestPermissionsFromUser(callback: (allowScope: boolean, allowPrecision: boolean) => void): void {
    this.atManager.requestPermissionsFromUser(this.context, locationPermission)
      .then((data: PermissionRequestResult) => {
        callback(data.authResults[1] === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED,
          data.authResults[0] === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED);
      })
      .catch((err: BusinessError) => {
        console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
      })
  }

  getLocationAddress(latitude: number, longitude: number, maxItems: number, callback:(error: BusinessError, data:  geoLocationManager.GeoAddress[]) => void) {
    let reverseGeocodeRequest:geoLocationManager.ReverseGeoCodeRequest = {"latitude": latitude, "longitude": longitude, "maxItems": maxItems};
    try {
      geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest, (err, data) => {
        callback(err, data);
      });
    } catch (err) {
      console.error("errCode:" + JSON.stringify(err));
    }
  }
}