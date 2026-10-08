import { BusStopStatus } from '../model/Models';
import { PageHeader, LoadingView } from '../view/CommonComponents';

@Component
export struct BusPage {
  @State currentTab: number = 0;
  @State stops: BusStopStatus[] = [];
  @State loading: boolean = true;
  @State taoyuanStatus: string = '';
  @State taoyuanLoading: boolean = false;
  @State collapse: number = 0;

  aboutToAppear(): void {
    this.loadTaipei();
  }

  loadTaipei(): void {
    this.loading = true;
    // Demo 假資料
    this.stops = [
      { stopid: 1, name: '銘傳大學(校門)', status: '3 分鐘到站', arriveTime: '3' },
      { stopid: 2, name: '教學大樓', status: '8 分鐘到站', arriveTime: '8' },
      { stopid: 3, name: '圖書館', status: '尚未發車', arriveTime: '' },
      { stopid: 4, name: '劍潭捷運站', status: '15 分鐘到站', arriveTime: '15' },
      { stopid: 5, name: '士林夜市', status: '交管不停靠', arriveTime: '' },
    ];
    this.loading = false;
  }

  loadTaoyuan(): void {
    this.taoyuanLoading = true;
    this.taoyuanStatus = 'Demo 展示：目前無校車資訊（示意資料）';
    this.taoyuanLoading = false;
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '校車時刻', subtitle: 'School Bus (Demo)', collapse: this.collapse })

      Tabs({ index: this.currentTab }) {
        TabContent() {
          Column() {
            Row({ space: 10 }) {
              Text('台北校區即時到站（Demo）')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1A1A1A')
                .layoutWeight(1)
              Button('重新整理')
                .fontSize(13)
                .height(34)
                .backgroundColor('#B02A30')
                .onClick(() => this.loadTaipei())
            }
            .width('100%')
            .padding(12)

            if (this.loading) {
              LoadingView()
            } else {
              List({ space: 8 }) {
                ForEach(this.stops, (s: BusStopStatus) => {
                  ListItem() {
                    Row() {
                      Column({ space: 4 }) {
                        Text(s.name)
                          .fontSize(15)
                          .fontWeight(FontWeight.Medium)
                          .fontColor('#1A1A1A')
                        Text(`站牌 ${s.stopid}`)
                          .fontSize(11)
                          .fontColor('#AAAAAA')
                      }
                      .alignItems(HorizontalAlign.Start)
                      .layoutWeight(1)

                      Text(s.status)
                        .fontSize(15)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.isArrival(s.status) ? '#2A7F62' : '#B45309')
                    }
                    .width('100%')
                    .padding(14)
                    .backgroundColor(Color.White)
                    .borderRadius(12)
                  }
                }, (s: BusStopStatus) => s.stopid.toString())
              }
              .width('100%')
              .padding({ left: 12, right: 12, bottom: 12 })
              .scrollBar(BarState.Off)
              .onScrollIndex((start: number) => {
                this.collapse = start > 0 ? 1 : 0;
              })
            }
          }
          .width('100%')
          .height('100%')
        }
        .tabBar('台北校區')

        TabContent() {
          Column({ space: 14 }) {
            Row({ space: 10 }) {
              Text('桃園校區校車（Demo）')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1A1A1A')
                .layoutWeight(1)
              Button('查詢')
                .fontSize(13)
                .height(34)
                .backgroundColor('#B02A30')
                .enabled(!this.taoyuanLoading)
                .onClick(() => this.loadTaoyuan())
            }
            .width('100%')
            .padding(12)

            if (this.taoyuanLoading) {
              LoadingView()
            } else {
              Scroll() {
                Text(this.taoyuanStatus.length > 0 ? this.taoyuanStatus : '點擊「查詢」取得桃園校車即時資訊')
                  .fontSize(14)
                  .fontColor('#333333')
                  .width('100%')
                  .padding(16)
              }
              .width('100%')
              .layoutWeight(1)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }
          }
          .width('100%')
          .height('100%')
        }
        .tabBar('桃園校區')
      }
      .layoutWeight(1)
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.currentTab = index;
        if (index === 1 && this.taoyuanStatus.length === 0) {
          this.loadTaoyuan();
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
    }
    .hideTitleBar(true)
  }

  private isArrival(status: string): boolean {
    return status.includes('分鐘') || status.includes('到站');
  }
}
