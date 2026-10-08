import { PageHeader, LoadingView, ErrorView } from '../view/CommonComponents';

interface LeaveRow {
  date: string;
  type: string;
  status: string;
  note: string;
}

@Component
export struct LeavePage {
  @State rows: LeaveRow[] = [];
  @State loading: boolean = true;
  @State error: boolean = false;
  @State collapse: number = 0;

  aboutToAppear(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.error = false;
    // Demo 假資料
    this.rows = [
      { date: '2025-03-10', type: '事假', status: '已核准', note: '' },
      { date: '2025-04-02', type: '病假', status: '待審核', note: '' },
    ];
    this.error = this.rows.length === 0;
    this.loading = false;
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '請假資訊', subtitle: 'Leave / Absence', collapse: this.collapse })

      if (this.loading) {
        LoadingView()
      } else if (this.error) {
        ErrorView({ text: '查無資料', retry: () => this.load() })
      } else {
        List({ space: 8 }) {
          ForEach(this.rows, (r: LeaveRow) => {
            ListItem() {
              Row() {
                Column({ space: 4 }) {
                  Text(r.type)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1A1A1A')
                  Text(r.date)
                    .fontSize(12)
                    .fontColor('#999999')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column({ space: 4 }) {
                  Text(r.status)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#2A7F62')
                  if (r.note.length > 0) {
                    Text(r.note)
                      .fontSize(11)
                      .fontColor('#999999')
                  }
                }
                .alignItems(HorizontalAlign.End)
              }
              .width('100%')
              .padding(14)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }
          }, (r: LeaveRow, i: number) => r.date + r.type + i.toString())
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
