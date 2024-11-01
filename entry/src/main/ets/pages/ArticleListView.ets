// @Observed and @ObjectLink

@Observed
class Article2 {
  id: string;
  title: string;
  brief: string;
  isLiked: boolean;
  likesCount: number;

  constructor(id: string, title: string, brief: string, isLiked: boolean, likesCount: number) {
    this.id = id;
    this.title = title;
    this.brief = brief;
    this.isLiked = isLiked;
    this.likesCount = likesCount;
  }
}

@Entry
@Component
struct ArticleListView {
  @State articleList: Array<Article2> = [
    new Article2('001', '第0篇文章', '文章简介内容', false, 100),
    new Article2('002', '第1篇文章', '文章简介内容', false, 100),
    new Article2('003', '第2篇文章', '文章简介内容', false, 100),
    new Article2('004', '第4篇文章', '文章简介内容', false, 100),
    new Article2('005', '第5篇文章', '文章简介内容', false, 100),
    new Article2('006', '第6篇文章', '文章简介内容', false, 100),
  ];

  build() {
    List() {
      ForEach(this.articleList, (item: Article2) => {
        ListItem() {
          ArticleCard2({
            article: item
          })
            .margin({ top: 20 })
        }
      }, (item: Article2) => item.id)
    }
    .padding(20)
    .scrollBar(BarState.Off)
    .backgroundColor(0xF1F3F5)
  }
}

@Component
@Reusable
struct ArticleCard2 {
  @ObjectLink article: Article2;
  onArticle?: () => void;

  handleLiked() {
    this.article.isLiked = !this.article.isLiked;
    this.article.likesCount = this.article.isLiked ? this.article.likesCount + 1 : this.article.likesCount - 1;
  }

  aboutToReuse(params: Record<string, Object>): void {
    this.onArticle = params.onArticle as () => void;
  }

  build() {
    Row() {
      Image($r('app.media.startIcon'))
        .width(80)
        .height(80)
        .margin({ right: 20 })

      Column() {
        Text(this.article.title)
          .fontSize(20)
          .margin({ bottom: 8 })
        Text(this.article.brief)
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ bottom: 8 })

        Row() {
          Image(this.article.isLiked ? $r('app.media.startIcon') : $r('app.media.foreground'))
            .width(24)
            .height(24)
            .margin({ right: 8 })
          Text(this.article.likesCount.toString())
            .fontSize(16)
        }
        .onClick(() => this.handleLiked())
        .justifyContent(FlexAlign.Center)
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
    .justifyContent(FlexAlign.SpaceBetween)
  }
}