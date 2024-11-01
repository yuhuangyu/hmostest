
// class PropB {
//   code: number;
//
//   constructor(code: number) {
//     this.code = code;
//   }
// }
// // 创建新实例并使用给定对象初始化
// let para: Record<string, number> = { 'PropA': 47 };
// let storage: LocalStorage = new LocalStorage(para);
// storage.setOrCreate('PropB', new PropB(50));
//
// @Component
// struct Child {
//   // @LocalStorageLink变量装饰器与LocalStorage中的'PropA'属性建立双向绑定
//   @LocalStorageLink('PropA') childLinkNumber: number = 1;
//   // @LocalStorageLink变量装饰器与LocalStorage中的'PropB'属性建立双向绑定
//   @LocalStorageLink('PropB') childLinkObject: PropB = new PropB(0);
//
//   build() {
//     Column() {
//       Button(`Child from LocalStorage ${this.childLinkNumber}`) // 更改将同步至LocalStorage中的'PropA'以及Parent.parentLinkNumber
//         .onClick(() => {
//           this.childLinkNumber += 1;
//         })
//       Button(`Child from LocalStorage ${this.childLinkObject.code}`) // 更改将同步至LocalStorage中的'PropB'以及Parent.parentLinkObject.code
//         .onClick(() => {
//           this.childLinkObject.code += 1;
//         })
//     }
//   }
// }

/*
 * ******************************************
 * */

// // 创建新实例并使用给定对象初始化
// let para2: Record<string, number> = { 'PropC': 47 };
// let storage2: LocalStorage = new LocalStorage(para2);
//
//
// @Component
// struct Child2 {
//   // @LocalStorageProp变量装饰器与LocalStorage中的'PropA'属性建立单向绑定
//   @LocalStorageProp('PropC') storageProp2: number = 2;
//
//   build() {
//     Column({ space: 15 }) {
//       // 当CompA改变时，当前storageProp2不会改变，显示47
//       Text(`Parent from LocalStorage ${this.storageProp2}`)
//     }
//   }
// }
// /*
//  * ******************************************
//  * */
//
// 构造LocalStorage实例
let para3: Record<string, number> = { 'PropD': 47 };
let storage3: LocalStorage = new LocalStorage(para3);
// 调用link（api9以上）接口构造'PropA'的双向同步数据，linkToPropA 是全局变量
let linkToPropA: SubscribedAbstractProperty<object> = storage3.link('PropD');



// 使LocalStorage可从@Component组件访问
@Entry(storage3)
// @Entry
@Component
struct LocalStoragePage {
  @State message: string = 'Hello World';

  // // @LocalStorageLink变量装饰器与LocalStorage中的'PropA'属性建立双向绑定
  // @LocalStorageLink('PropA') parentLinkNumber: number = 1;
  // // @LocalStorageLink变量装饰器与LocalStorage中的'PropB'属性建立双向绑定
  // @LocalStorageLink('PropB') parentLinkObject: PropB = new PropB(0);

  // // @LocalStorageProp变量装饰器与LocalStorage中的'PropA'属性建立单向绑定
  // @LocalStorageProp('PropC') storageProp1: number = 1;

  // @LocalStorageLink('PropA')在CompA自定义组件中创建'PropA'的双向同步数据，初始值为47，因为在构造LocalStorage已经给“PropA”设置47
  @LocalStorageLink('PropD') storageLink: number = 1;



  build() {
    Column({ space: 15 }) {
      // Button(`Parent from LocalStorage ${this.parentLinkNumber}`) // initial value from LocalStorage will be 47, because 'PropA' initialized already
      //   .onClick(() => {
      //     this.parentLinkNumber += 1;
      //   })
      //
      // Button(`Parent from LocalStorage ${this.parentLinkObject.code}`) // initial value from LocalStorage will be 50, because 'PropB' initialized already
      //   .onClick(() => {
      //     this.parentLinkObject.code += 1;
      //   })
      // // @Component子组件自动获得对CompA LocalStorage实例的访问权限。
      // Child()


      // 点击后从47开始加1，只改变当前组件显示的storageProp1，不会同步到LocalStorage中
      // Button(`Parent from LocalStorage ${this.storageProp1}`)
      //   .onClick(() => {
      //     this.storageProp1 += 1
      //   })
      // Child2()

      Text(`incr @LocalStorageLink variable`)
        // 点击“incr @LocalStorageLink variable”，this.storageLink加1，改变同步回storage，全局变量linkToPropA也会同步改变

        .onClick(() => {
          this.storageLink += 1
        })

      // 并不建议在组件内使用全局变量linkToPropA.get()，因为可能会有生命周期不同引起的错误。
      Text(`@LocalStorageLink: ${this.storageLink} - linkToPropA: ${linkToPropA.get()}`)
    }
  }
}


