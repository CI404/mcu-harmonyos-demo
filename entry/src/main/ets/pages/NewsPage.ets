import { NewsItem } from '../model/Models';
import { PageHeader, LoadingView } from '../view/CommonComponents';

interface Feed {
  title: string;
}

@Component
export struct NewsPage {
  @State items: NewsItem[] = [];
  @State loading: boolean = true;
  @State collapse: number = 0;
  @State currentFeed: number = 0;
  @State feeds: Feed[] = [
    { title: '焦點新聞' },
    { title: '校園快訊' },
    { title: '活動連線' },
  ];

  aboutToAppear(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    // Demo 假資料，不連網
    this.items = [
      { title: 'Demo：校園春季健行活動開放報名', link: '', pubDate: '2025-03-01', description: '此為展示用佔位內容，僅用於呈現新聞列表的視覺效果。' },
      { title: 'Demo：圖書館週末延長開放', link: '', pubDate: '2025-03-02', description: '此為展示用佔位內容。' },
      { title: 'Demo：國際交流週系列講座', link: '', pubDate: '2025-03-03', description: '此為展示用佔位內容。' },
    ];
    this.loading = false;
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '校園新聞', subtitle: 'News & Announcements', collapse: this.collapse })

      Tabs({ index: this.currentFeed }) {
        ForEach(this.feeds, (f: Feed) => {
          TabContent() {
            if (this.loading) {
              LoadingView()
            } else {
              List({ space: 10 }) {
                ForEach(this.items, (item: NewsItem) => {
                  ListItem() {
                    Column({ space: 6 }) {
                      Text(item.title)
                        .fontSize(15)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#1A1A1A')
                        .maxLines(2)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                      if (item.pubDate.length > 0) {
                        Text(item.pubDate)
                          .fontSize(12)
                          .fontColor('#999999')
                      }
                      if (item.description.length > 0) {
                        Text(item.description)
                          .fontSize(13)
                          .fontColor('#666666')
                          .maxLines(3)
                          .textOverflow({ overflow: TextOverflow.Ellipsis })
                      }
                    }
                    .alignItems(HorizontalAlign.Start)
                    .width('100%')
                    .padding(14)
                    .backgroundColor(Color.White)
                    .borderRadius(12)
                  }
                }, (item: NewsItem) => item.pubDate + item.title)
              }
              .width('100%')
              .padding({ left: 16, right: 16, top: 12, bottom: 12 })
              .scrollBar(BarState.Off)
              .onScrollIndex((start: number) => {
                this.collapse = start > 0 ? 1 : 0;
              })
            }
          }
          .tabBar(f.title)
        }, (f: Feed) => f.title)
      }
      .layoutWeight(1)
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.currentFeed = index;
        this.load();
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
    }
    .hideTitleBar(true)
  }
}
