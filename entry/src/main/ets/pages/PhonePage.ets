import { pasteboard } from '@kit.BasicServicesKit';
import { PHONE_BOOK, PhoneEntry } from '../common/Constants';
import { PageHeader } from '../view/CommonComponents';

@Component
export struct PhonePage {
  @State selected: number = 0;
  @State collapse: number = 0;
  private campuses: string[] = ['台北', '桃園', '金門'];

  private items(campus: string): PhoneEntry[] {
    return PHONE_BOOK.filter((p: PhoneEntry) => p.campus === campus);
  }

  private call(number: string): void {
    try {
      const clipboard = pasteboard.getSystemPasteboard();
      const data = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, number);
      clipboard.setData(data);
    } catch (e) {
      // ignore
    }
    try {
      this.getUIContext().getPromptAction().showToast({ message: `已複製號碼 ${number}` });
    } catch (e) {
      // ignore
    }
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '電話查詢', subtitle: 'Campus Directory', collapse: this.collapse })

      Tabs({ index: this.selected }) {
        ForEach(this.campuses, (campus: string) => {
          TabContent() {
            List({ space: 8 }) {
              ForEach(this.items(campus), (p: PhoneEntry) => {
                ListItem() {
                  Row({ space: 12 }) {
                    Text('📞')
                      .fontSize(20)
                    Column({ space: 3 }) {
                      Text(p.dept)
                        .fontSize(15)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#1A1A1A')
                      Text(p.campus + '校區')
                        .fontSize(12)
                        .fontColor('#999999')
                    }
                    .alignItems(HorizontalAlign.Start)
                    .layoutWeight(1)
                    Text(p.number)
                      .fontSize(15)
                      .fontColor('#B02A30')
                  }
                  .width('100%')
                  .padding(14)
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .onClick(() => this.call(p.number))
                }
              }, (p: PhoneEntry) => p.campus + p.dept)
            }
            .width('100%')
            .padding({ left: 14, right: 14, top: 12, bottom: 12 })
            .scrollBar(BarState.Off)
            .onScrollIndex((start: number) => {
              this.collapse = start > 0 ? 1 : 0;
            })
          }
          .tabBar(campus)
        }, (campus: string) => campus)
      }
      .layoutWeight(1)
      .barMode(BarMode.Fixed)

      Text('點擊號碼即可複製到剪貼簿')
        .fontSize(12)
        .fontColor('#AAAAAA')
        .padding({ bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
    }
    .hideTitleBar(true)
  }
}
