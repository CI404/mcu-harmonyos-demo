import { Nav } from '../common/Nav';
import { SessionManager } from '../common/SessionManager';
import { LifeCategory } from '../model/Models';
import { PageHeader, LoadingView, ErrorView } from '../view/CommonComponents';

interface LifeEntry {
  title: string;
  icon: string;
  color: string;
  kind: string;
}

@Component
export struct CampusLifePage {
  @State loading: boolean = true;
  @State error: boolean = false;
  @State collapse: number = 0;
  @State categories: LifeCategory[] = [];

  private staticEntries: LifeEntry[] = [
    { title: '美食餐飲', icon: '🍜', color: '#E4572E', kind: '美食' },
    { title: '衣著服飾', icon: '👕', color: '#1B4F8A', kind: '衣著' },
    { title: '文教育樂', icon: '🎓', color: '#7D5BA6', kind: '文教育樂' },
    { title: '生活百貨', icon: '🛍️', color: '#2A7F62', kind: '生活' },
  ];

  aboutToAppear(): void {
    this.load();
  }

  async load(): Promise<void> {
    // IL 中無 LifeList 介面，校園生活為靜態分類，不呼叫 API
    this.loading = false;
    this.error = false;
    this.categories = [];
  }

  /** 校區編號：台北=1, 桃園=2, 金門=3 */
  private campusId(): string {
    const c = SessionManager.getSession().campus;
    if (c === '桃園') {
      return '2';
    }
    if (c === '金門') {
      return '3';
    }
    return '1';
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '校園生活', subtitle: 'Campus Life', collapse: this.collapse })

      if (this.loading) {
        LoadingView()
      } else if (this.error) {
        ErrorView({ text: '查無資料', detail: '', retry: () => this.load() })
      } else {
        Scroll() {
          Column({ space: 12 }) {
            Grid() {
              ForEach(this.staticEntries, (e: LifeEntry) => {
                GridItem() {
                  Column({ space: 8 }) {
                    Text(e.icon)
                      .fontSize(30)
                    Text(e.title)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#1A1A1A')
                  }
                  .width('100%')
                  .padding({ top: 16, bottom: 16 })
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .onClick(() => {
                    Nav.push('pages/WebPage', { kind: e.kind, title: e.title });
                  })
                }
              }, (e: LifeEntry) => e.title)
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(10)
            .rowsGap(10)

            if (this.categories.length > 0) {
              Text('周邊店家分類')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1A1A1A')
                .width('100%')
                .padding({ top: 4 })

              List({ space: 8 }) {
                ForEach(this.categories, (c: LifeCategory) => {
                  ListItem() {
                    Row() {
                      Text(c.Cname)
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
                  }
                }, (c: LifeCategory) => c.Id + c.Cname)
              }
              .width('100%')
            }
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
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
    }
    .hideTitleBar(true)
  }
}
