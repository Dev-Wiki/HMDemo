import { abilityAccessCtrl, bundleManager, common, PermissionRequestResult, Permissions } from '@kit.AbilityKit';
import { geoLocationManager } from '@kit.LocationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { LocationHelper } from '../../utils/LocationHelper';

@Component
@Entry({routeName: 'MapPage'})
struct MapPage {
  @State isShowLocationPopup: boolean = false
  appName: string = ''
  @State isLocationPermission: boolean = false;
  @State locText: string = ''

  locationHelper: LocationHelper = new LocationHelper(getContext(this) as common.UIAbilityContext);

  @Builder
  locationViewBuilder() {
    Row() {
      Text('开启定位权限').fontSize(15);
      Button('去开启')
        .type(ButtonType.Normal)
        .height(24)
        .borderRadius(12)
        .width(60)
        .backgroundColor(Color.Red)
        .onClick(() => {
          if (this.isLocationPermission) {
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
    this.locationHelper.requestPermissionsFromUser((allowScope: boolean, allowPrecision: boolean) => {

    })
  }
}