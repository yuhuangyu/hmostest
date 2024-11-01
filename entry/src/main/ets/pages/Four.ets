
class Article {
  id: string;
  title: string;
  brief: string;

  constructor(id: string, title: string, brief: string) {
    this.id = id;
    this.title = title;
    this.brief = brief;
  }
}

@Entry
@Component
struct Four {
  @State message: string = 'Hello World';
  @State simpleList: Array<number> = [1, 2, 3, 4, 5];

  @State isListReachEnd: boolean = false;
  @State articleList: Array<Article> = [
    new Article('001', '第1篇文章', '文章简介内容'),
    new Article('002', '第2篇文章', '文章简介内容'),
    new Article('003', '第3篇文章', '文章简介内容'),
    new Article('004', '第4篇文章', '文章简介内容'),
    new Article('005', '第5篇文章', '文章简介内容'),
    new Article('006', '第6篇文章', '文章简介内容')
  ]

  loadMoreArticles() {
    this.articleList.push(new Article('007', '加载的新文章', '文章简介内容'));
  }

  // build() {
  //   Column() {
  //     ForEach(this.simpleList, (item: number) => {
  //       ArticleSkeletonView()
  //         .margin({ top: 20 })
  //     }, (item: number) => item.toString())
  //   }
  //   .padding(20)
  //   .width('100%')
  //   .height('100%')
  // }
  build() {
    Column() {
      List({ space: 24 }) {
        ForEach(this.articleList, (item: Article) => {
          ListItem() {
            ArticleCard({ article: item })
              // .margin({ top: 20 })
          }
        }, (item: Article) => item.id)
      }
      .onReachEnd(() => {
        this.isListReachEnd = true;
      })
      .parallelGesture(
        PanGesture({ direction: PanDirection.Up, distance: 80 })
          .onActionStart(() => {
            if (this.isListReachEnd) {
              this.loadMoreArticles();
              this.isListReachEnd = false;
            }
          })
      )
      .padding({left: 12, right: 12, top: 24, bottom: 24})
      .backgroundColor(Color.Gray)
      .borderRadius(16)
      .scrollBar(BarState.Off)
      .divider({
        strokeWidth: 0.5,
        startMargin: 0,
        endMargin: 0,
        color: '#22F2F2'
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xF1F3F5)
  }
}

@Component
struct ArticleCard {
  @Prop article: Article;

  build() {
    Row() {
      Image($r('app.media.startIcon'))
        .width(80)
        .height(80)
        .margin({ right: 20 })
      Blank()  // 该组件可以自动填充主轴方向的空余空间
      Column() {
        Text(this.article.title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold) // FontWeight.Bold 相当于 700, 定义文本的字体粗细。
          .lineHeight(33)   //行高属性为33。
          .margin({ bottom: 8 })
        Text(this.article.brief)
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ bottom: 8 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('80%')
      .height('100%')
    }
    .padding(20)
    .borderRadius(12)
    .backgroundColor('#FFECECEC')
    .height(120)
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
  }
}



@Component
struct ArticleSkeletonView {
  build() {
    Row() {
      Column() {
        textArea(80, 80)
      }
      .margin({ right: 20 })

      Column() {
        textArea('60%', 20)
        textArea('50%', 20)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceAround)
      .height('100%')
    }
    .padding(20)
    .borderRadius(12)
    .backgroundColor('#FFECECEC')
    .height(120)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Builder
function textArea(width: number | Resource | string = '100%', height: number | Resource | string = '100%') {
  Row()
    .width(width)
    .height(height)
    .backgroundColor('#FFF2F3F4')
}