import { Nav } from '../common/Nav';
import { PageHeader } from '../view/CommonComponents';

@Component
export struct NoteDetailPage {
  @State title: string = '';
  @State content: string = '';
  @State date: string = '';

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '訊息詳情', subtitle: 'Message Detail' })

      Scroll() {
        Column({ space: 14 }) {
          Text(this.title)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1A1A')
            .width('100%')
            .copyOption(CopyOptions.LocalDevice)
          if (this.date.length > 0) {
            Text(this.date)
              .fontSize(12)
              .fontColor('#999999')
              .width('100%')
          }
          Text(this.content)
            .fontSize(15)
            .fontColor('#333333')
            .width('100%')
            .lineHeight(24)
            .copyOption(CopyOptions.LocalDevice)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
    }
    .hideTitleBar(true)
    .onReady((ctx: NavDestinationContext) => {
      const p = ctx.pathInfo.param as Record<string, string>;
      if (p !== undefined) {
        this.title = p['title'] !== undefined ? p['title'] : '';
        this.content = p['content'] !== undefined ? p['content'] : '';
        this.date = p['date'] !== undefined ? p['date'] : '';
      }
    })
  }
}
