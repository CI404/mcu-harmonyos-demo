import { PageHeader, LoadingView, EmptyView, ErrorView } from '../view/CommonComponents';

interface ExamRow {
  date: string;
  day: string;
  period: string;
  course: string;
  room: string;
  seat: string;
}

@Component
export struct ExamPage {
  @State currentTab: number = 0;
  @State midRows: ExamRow[] = [];
  @State finalRows: ExamRow[] = [];
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
    const mid: ExamRow[] = [
      { date: '2025-04-14', day: '一', period: '3', course: '程式設計', room: 'B301', seat: '12' },
      { date: '2025-04-15', day: '二', period: '2', course: '資料結構', room: 'B202', seat: '8' },
    ];
    const fin: ExamRow[] = [
      { date: '2025-06-16', day: '一', period: '3', course: '程式設計', room: 'B301', seat: '12' },
      { date: '2025-06-17', day: '二', period: '2', course: '資料結構', room: 'B202', seat: '8' },
    ];
    this.midRows = mid;
    this.finalRows = fin;
    this.loading = false;
  }

  @Builder
  ExamList(rows: ExamRow[]) {
    if (rows.length === 0) {
      EmptyView()
    } else {
      List({ space: 8 }) {
        ForEach(rows, (r: ExamRow) => {
          ListItem() {
            Column({ space: 6 }) {
              Row() {
                Text(r.course)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1A1A1A')
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .layoutWeight(1)
                Text(r.period + ' 節')
                  .fontSize(13)
                  .fontColor('#B02A30')
              }
              .width('100%')

              Row({ space: 12 }) {
                Text(`日期：${r.date}`)
                  .fontSize(12)
                  .fontColor('#666666')
                Text(`教室：${r.room}`)
                  .fontSize(12)
                  .fontColor('#666666')
                Text(`座位：${r.seat}`)
                  .fontSize(12)
                  .fontColor('#666666')
              }
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(14)
            .backgroundColor(Color.White)
            .borderRadius(12)
          }
        }, (r: ExamRow, i: number) => r.course + i.toString())
      }
      .width('100%')
      .padding(16)
      .scrollBar(BarState.Off)
      .onScrollIndex((start: number) => {
        this.collapse = start > 0 ? 1 : 0;
      })
    }
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '考試資訊', subtitle: 'Exam Schedule & Location', collapse: this.collapse })

      if (this.loading) {
        LoadingView()
      } else if (this.error) {
        ErrorView({ text: '查無資料', retry: () => this.load() })
      } else {
        Tabs({ index: this.currentTab }) {
          TabContent() { this.ExamList(this.midRows) }.tabBar('期中考')
          TabContent() { this.ExamList(this.finalRows) }.tabBar('期末考')
        }
        .layoutWeight(1)
        .barMode(BarMode.Fixed)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
    }
    .hideTitleBar(true)
  }
}
