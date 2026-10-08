import { PageHeader } from '../view/CommonComponents';

@Component
export struct CalendarPage {
  @State lang: string = '中文';

  private switchLang(): void {
    this.lang = this.lang === '中文' ? 'English' : '中文';
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '行事曆', subtitle: 'Academic Calendar' })

      Row({ space: 10 }) {
        Text(this.lang === '中文' ? '109 學年度行事曆（Demo）' : 'Academic Calendar (Demo)')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
          .layoutWeight(1)
        Button(this.lang)
          .fontSize(13)
          .height(34)
          .backgroundColor('#B02A30')
          .onClick(() => this.switchLang())
      }
      .width('100%')
      .padding(12)

      Column({ space: 10 }) {
        Text('📅')
          .fontSize(48)
        Text('Demo 行事曆')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
        Text('本 demo 不含行事曆 PDF 內容')
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
  }
}
