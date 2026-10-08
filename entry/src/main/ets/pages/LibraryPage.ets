import { PageHeader, LoadingView, ErrorView } from '../view/CommonComponents';

interface BookRow {
  name: string;
  author: string;
  borrowDate: string;
  dueDate: string;
}

@Component
export struct LibraryPage {
  @State rows: BookRow[] = [];
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
      { name: '深入淺出程式設計（Demo）', author: '示例作者', borrowDate: '2025-02-01', dueDate: '2025-03-01' },
      { name: '資料結構與演算法（Demo）', author: '示例作者', borrowDate: '2025-02-10', dueDate: '2025-03-10' },
    ];
    this.error = this.rows.length === 0;
    this.loading = false;
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '圖書館', subtitle: 'Library', collapse: this.collapse })

      Row() {
        Text('我的借閱（Demo）')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .layoutWeight(1)
      }
      .width('100%')
      .padding(14)

      if (this.loading) {
        LoadingView()
      } else if (this.error) {
        ErrorView({ text: '查無借閱資料', retry: () => this.load() })
      } else {
        List({ space: 8 }) {
          ForEach(this.rows, (r: BookRow) => {
            ListItem() {
              Column({ space: 8 }) {
                Row() {
                  Text('📖')
                    .fontSize(20)
                  Text(r.name)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1A1A1A')
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .layoutWeight(1)
                }
                .width('100%')

                Text(r.author.length > 0 ? `作者：${r.author}` : '')
                  .fontSize(12)
                  .fontColor('#666666')
                  .width('100%')
                Row() {
                  Text(`借閱：${r.borrowDate}`)
                    .fontSize(12)
                    .fontColor('#999999')
                    .layoutWeight(1)
                  Text(`到期：${r.dueDate}`)
                    .fontSize(12)
                    .fontColor('#B02A30')
                }
                .width('100%')
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .padding(14)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }
          }, (r: BookRow, i: number) => r.name + i.toString())
        }
        .width('100%')
        .padding({ left: 14, right: 14, bottom: 14 })
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
