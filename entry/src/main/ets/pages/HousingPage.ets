import { RentItem } from '../model/Models';
import { PageHeader, LoadingView, ErrorView } from '../view/CommonComponents';

@Component
export struct HousingPage {
  @State cities: RentItem[] = [];
  @State towns: RentItem[] = [];
  @State results: RentItem[] = [];
  @State loading: boolean = true;
  @State error: boolean = false;
  @State collapse: number = 0;
  @State currentCity: string = '';
  @State currentTown: string = '';

  aboutToAppear(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.error = false;
    this.levelReset();
    // Demo 假資料
    this.cities = [
      { Id: '1', Cname: '台北市', Tname: '', Grade: '', TotalCount: '', PicPath: '' },
      { Id: '2', Cname: '桃園市', Tname: '', Grade: '', TotalCount: '', PicPath: '' },
    ];
    this.error = this.cities.length === 0;
    this.loading = false;
  }

  private levelReset(): void {
    this.cities = [];
    this.towns = [];
    this.results = [];
    this.currentCity = '';
    this.currentTown = '';
  }

  loadTowns(city: RentItem): void {
    this.currentCity = city.Cname;
    this.towns = [];
    this.results = [];
    this.loading = true;
    this.towns = [
      { Id: '11', Cname: '士林區', Tname: '士林區', Grade: '', TotalCount: '', PicPath: '' },
      { Id: '12', Cname: '北投區', Tname: '北投區', Grade: '', TotalCount: '', PicPath: '' },
    ];
    this.loading = false;
  }

  loadResults(town: RentItem): void {
    this.currentTown = town.Tname.length > 0 ? town.Tname : town.Cname;
    this.results = [];
    this.loading = true;
    this.results = [
      { Id: '101', Cname: '示範套房 A', Tname: '近校區', Grade: '8,000 元/月', TotalCount: '1', PicPath: '' },
      { Id: '102', Cname: '示範套房 B', Tname: '近捷運', Grade: '9,500 元/月', TotalCount: '1', PicPath: '' },
    ];
    this.loading = false;
  }

  @Builder
  Breadcrumb() {
    Row({ space: 6 }) {
      Text('租屋地區查詢（Demo）')
        .fontSize(14)
        .fontColor(this.currentCity.length === 0 ? '#B02A30' : '#999999')
        .onClick(() => this.load())
      if (this.currentCity.length > 0) {
        Text('›')
          .fontSize(14)
          .fontColor('#999999')
        Text(this.currentCity)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentTown.length === 0 ? '#B02A30' : '#999999')
      }
      if (this.currentTown.length > 0) {
        Text('›')
          .fontSize(14)
          .fontColor('#999999')
        Text(this.currentTown)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B02A30')
      }
      Blank()
    }
    .width('100%')
    .padding({ left: 14, right: 14, top: 12, bottom: 4 })
  }

  @Builder
  ItemRow(r: RentItem, isLeaf: boolean, onTap: () => void) {
    Row() {
      Column({ space: 4 }) {
        Text(r.Cname)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
        if (r.Tname.length > 0) {
          Text(r.Tname)
            .fontSize(12)
            .fontColor('#999999')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        if (r.Grade.length > 0) {
          Text(r.Grade)
            .fontSize(12)
            .fontColor('#B02A30')
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (r.TotalCount.length > 0) {
        Text(`${r.TotalCount} 筆`)
          .fontSize(13)
          .fontColor('#B02A30')
      } else if (!isLeaf) {
        Text('›')
          .fontSize(20)
          .fontColor('#CCCCCC')
      }
    }
    .width('100%')
    .padding(14)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .onClick(() => {
      onTap();
    })
  }

  build() {
    NavDestination() {
    Column() {
      PageHeader({ title: '宿舍租屋', subtitle: 'Housing & Rental', collapse: this.collapse })

      this.Breadcrumb()

      if (this.loading) {
        LoadingView()
      } else if (this.error) {
        ErrorView({ text: '查無租屋資料', retry: () => this.load() })
      } else {
        List({ space: 8 }) {
          if (this.results.length > 0) {
            ForEach(this.results, (r: RentItem) => {
              ListItem() {
                this.ItemRow(r, true, () => {})
              }
            }, (r: RentItem, i: number) => 'res' + r.Id + i.toString())
          } else if (this.towns.length > 0) {
            ForEach(this.towns, (r: RentItem) => {
              ListItem() {
                this.ItemRow(r, false, () => { this.loadResults(r); })
              }
            }, (r: RentItem, i: number) => 'town' + r.Id + i.toString())
          } else {
            ForEach(this.cities, (r: RentItem) => {
              ListItem() {
                this.ItemRow(r, false, () => { this.loadTowns(r); })
              }
            }, (r: RentItem, i: number) => 'city' + r.Id + i.toString())
          }
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
