import { PageHeader, LoadingView, ErrorView } from '../view/CommonComponents';

interface RoomRow {
  roomNo: string;
  name: string;
  building: string;
  floor: string;
  capacity: string;
  status: string;
}

@Component
export struct RoomPage {
  @State rows: RoomRow[] = [];
  @State loading: boolean = true;
  @State error: boolean = false;
  @State collapse: number = 0;
  @State building: string = 'B';
  private buildings: string[] = ['B', 'D', 'E', 'F', 'H', 'P', 'S', 'EE', 'J', 'A'];

  aboutToAppear(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.error = false;
    // Demo 假資料
    this.rows = [
      { roomNo: `${this.building}301`, name: '一般教室', building: this.building, floor: '3', capacity: '60', status: '空閒' },
      { roomNo: `${this.building}302`, name: '一般教室', building: this.building, floor: '3', capacity: '60', status: '使用中' },
      { roomNo: `${this.building}201`, name: '電腦教室', building: this.building, floor: '2', capacity: '45', status: '空閒' },
    ];
    this.error = this.rows.length === 0;
    this.loading = false;
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '教室查詢', subtitle: 'Classroom Query', collapse: this.collapse })

      Scroll() {
        Row({ space: 8 }) {
          ForEach(this.buildings, (b: string) => {
            Text(b)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.building === b ? Color.White : '#1A1A1A')
              .padding({ left: 16, right: 16, top: 7, bottom: 7 })
              .backgroundColor(this.building === b ? '#B02A30' : '#F2F3F5')
              .borderRadius(16)
              .onClick(() => {
                this.building = b;
                this.load();
              })
          }, (b: string) => b)
        }
        .padding({ left: 14, right: 14, top: 10, bottom: 4 })
      }
      .width('100%')
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)

      if (this.loading) {
        LoadingView()
      } else if (this.error) {
        ErrorView({ text: '查無資料', detail: '', retry: () => this.load() })
      } else {
        List({ space: 8 }) {
          ForEach(this.rows, (r: RoomRow) => {
            ListItem() {
              Row() {
                Column({ space: 4 }) {
                  Text(r.name.length > 0 ? r.name : r.roomNo)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1A1A1A')
                  Text(`${r.building} ${r.floor}樓`)
                    .fontSize(12)
                    .fontColor('#999999')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                if (r.status.length > 0) {
                  Text(r.status)
                    .fontSize(13)
                    .fontColor('#2A7F62')
                }
              }
              .width('100%')
              .padding(14)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }
          }, (r: RoomRow, i: number) => r.roomNo + i.toString())
        }
        .width('100%')
        .padding(16)
        .scrollBar(BarState.Off)
        .onScrollIndex((start: number) => {
          this.collapse = start > 0 ? 1 : 0;
        })
        .layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
    }
    .hideTitleBar(true)
  }
}
