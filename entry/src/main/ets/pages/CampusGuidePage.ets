import { common } from '@kit.AbilityKit';
import { CAMPUS_SPOTS } from '../common/Constants';
import { PageHeader } from '../view/CommonComponents';

interface Spot {
  name: string;
  lat: number;
  lng: number;
}

@Component
export struct CampusGuidePage {
  @State spots: Spot[] = CAMPUS_SPOTS;
  @State collapse: number = 0;

  private openMap(s: Spot): void {
    try {
      const hostCtx = this.getUIContext().getHostContext();
      if (hostCtx === undefined) {
        return;
      }
      const ctx = hostCtx as common.UIAbilityContext;
      ctx.startAbility({
        action: 'ohos.want.action.viewData',
        entities: ['entity.system.browsable'],
        uri: `geo:${s.lat},${s.lng}?q=${s.name}`
      });
    } catch (e) {
      // 失敗時以經緯度字串提示
    }
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '校園導覽', subtitle: 'Campus Map & Locations', collapse: this.collapse })

      Scroll() {
        Column({ space: 12 }) {
          Column({ space: 8 }) {
            Text('臺北校區')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1A1A1A')
              .width('100%')
            Text('111 臺北市士林區中山北路五段 250 號')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(14)
          .backgroundColor(Color.White)
          .borderRadius(12)

          Text('鄰近地標（點擊以花瓣地圖開啟）')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1A1A1A')
            .width('100%')
            .padding({ top: 4 })

          ForEach(this.spots, (s: Spot) => {
            Row({ space: 10 }) {
              Text('📍')
                .fontSize(20)
              Text(s.name)
                .fontSize(15)
                .fontColor('#1A1A1A')
                .layoutWeight(1)
              Text('›')
                .fontSize(20)
                .fontColor('#CCCCCC')
            }
            .width('100%')
            .padding(14)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .onClick(() => {
              this.openMap(s);
            })
          }, (s: Spot) => s.name)
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .onDidScroll((xOffset: number, yOffset: number) => {
        this.collapse = yOffset > 80 ? 1 : 0;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
    }
    .hideTitleBar(true)
  }
}
