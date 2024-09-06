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