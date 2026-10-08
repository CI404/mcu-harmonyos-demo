import { PageHeader } from '../view/CommonComponents';

@Component
export struct WebPage {
  @State title: string = 'Demo';

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: this.title, showBack: true })

      Column({ space: 10 }) {
        Text('🖼️')
          .fontSize(48)
        Text('Demo 展示頁')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
        Text('本 demo 不含任何網頁 / 外部內容')
          .fontSize(13)
          .fontColor('#999999')
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
    }
    .hideTitleBar(true)
    .onReady((ctx: NavDestinationContext) => {
      const p = ctx.pathInfo.param as Record<string, string>;
      if (p !== undefined && p['title'] !== undefined) {
        this.title = p['title'];
      }
    })
  }
}
