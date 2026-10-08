import { Nav } from '../common/Nav';
import { NoteItem } from '../model/Models';
import { PageHeader, LoadingView, ErrorView } from '../view/CommonComponents';

@Component
export struct NotePage {
  @State rows: NoteItem[] = [];
  @State loading: boolean = true;
  @State error: boolean = false;
  @State collapse: number = 0;
  @State unread: number = 0;

  aboutToAppear(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.error = false;
    // Demo 假資料
    this.unread = 2;
    this.rows = [
      { Id: '1', title: 'Demo：系統維護公告', content: '本週六 22:00-24:00 系統維護，此為展示用佔位內容。', date: '2025-03-01', unread: true },
      { Id: '2', title: 'Demo：獎學金申請通知', content: '獎學金申請已開放，此為展示用佔位內容。', date: '2025-03-02', unread: true },
      { Id: '3', title: 'Demo：社團博覽會', content: '社團博覽會將於下週舉行，此為展示用佔位內容。', date: '2025-03-03', unread: false },
    ];
    this.error = this.rows.length === 0;
    this.loading = false;
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '校園訊息', subtitle: 'Messages / Notices', collapse: this.collapse })

      if (this.unread > 0) {
        Row() {
          Text(`您有 ${this.unread} 則未讀訊息`)
            .fontSize(13)
            .fontColor('#B02A30')
            .layoutWeight(1)
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FBEEE9')
      }

      if (this.loading) {
        LoadingView()
      } else if (this.error) {
        ErrorView({ text: '目前無訊息', retry: () => this.load() })
      } else {
        List({ space: 8 }) {
          ForEach(this.rows, (r: NoteItem) => {
            ListItem() {
              Column({ space: 6 }) {
                Row() {
                  Text(r.title)
                    .fontSize(15)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1A1A1A')
                    .layoutWeight(1)
                  Text(r.date)
                    .fontSize(11)
                    .fontColor('#999999')
                }
                .width('100%')
                Text(r.content)
                  .fontSize(13)
                  .fontColor('#666666')
                  .maxLines(3)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .width('100%')
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .padding(14)
              .backgroundColor(Color.White)
              .borderRadius(12)
              .onClick(() => {
                Nav.push('pages/NoteDetailPage', { title: r.title, content: r.content, date: r.date });
              })
            }
          }, (r: NoteItem, i: number) => r.Id + i.toString())
        }
        .width('100%')
        .padding(14)
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
