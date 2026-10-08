import { PageHeader, LoadingView, ErrorView } from '../view/CommonComponents';

interface GradeRow {
  term: string;
  course: string;
  credit: string;
  score: string;
}

@Component
export struct GradesPage {
  @State rows: GradeRow[] = [];
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
      { term: '1131', course: '程式設計（Demo）', credit: '3', score: '92' },
      { term: '1131', course: '資料結構（Demo）', credit: '3', score: '88' },
      { term: '1131', course: '線性代數（Demo）', credit: '2', score: '85' },
    ];
    this.error = this.rows.length === 0;
    this.loading = false;
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '成績查詢', subtitle: 'Grades', collapse: this.collapse })

      if (this.loading) {
        LoadingView()
      } else if (this.error) {
        ErrorView({ text: '查無資料', detail: '', retry: () => this.load() })
      } else {
        List({ space: 8 }) {
          ForEach(this.rows, (r: GradeRow) => {
            ListItem() {
              Row() {
                Column({ space: 4 }) {
                  Text(r.course)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1A1A1A')
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  Text(r.term)
                    .fontSize(12)
                    .fontColor('#999999')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column({ space: 4 }) {
                  Text(r.score)
                    .fontSize(17)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#B02A30')
                  Text(`學分 ${r.credit}`)
                    .fontSize(11)
                    .fontColor('#999999')
                }
                .alignItems(HorizontalAlign.End)
              }
              .width('100%')
              .padding(14)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }
          }, (r: GradeRow, i: number) => r.course + i.toString())
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
