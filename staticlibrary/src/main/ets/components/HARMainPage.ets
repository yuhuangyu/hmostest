@Component
export struct HARMainPage {
  @State message: string = 'HAR MainPage';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
  }
}
