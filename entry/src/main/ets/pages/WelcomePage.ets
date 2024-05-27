
import common from '@ohos.app.ability.common'
import UserPrivacyDialog from '../view/welcome/UserPrivacyDialog'
import PreferenceUtil from'../common/utils/PreferenceUtil'
import router from '@ohos.router'


@Extend(Text)
//可以自己设置数值参数，不设置就按默认处理
function textStyle(fontsize:number = 12,opacity:number = 0.8){
  .fontSize(fontsize)
  //透明度
  .opacity(opacity)
  .fontColor(Color.White)
}
//常量
const PREF_KEY = 'userPrivacyKey'

@Entry
@Component
struct WelcomePage {

  //退出机制实现   上下文context  类型是common.UIAbilityContext
  context = getContext(this) as common.UIAbilityContext
  controller: CustomDialogController = new CustomDialogController({
    builder: UserPrivacyDialog({
      confrim: () => this.onConfirm(),
      concel: () => this.exitApp()
    })
  })

  async aboutToAppear() {
    //1.加载首选项
    let isAgree = await PreferenceUtil.getPreferenceValue(PREF_KEY, false)
    //2.判断是否同意
    if (isAgree) {
      //2.1同意，跳转首页
      this.jumpToIndex()
    } else {
      //2.2不同意，弹窗
      this.controller.open()
    }
  }

  jumpToIndex() {
    //不需要压栈，只需要使用一次就可以，所以用replace
    setTimeout(() => {
      router.replaceUrl({
        url: 'pages/Page_of_First'
      })
    }, 1000) //单位毫秒
  }

  onConfirm() {
    //1.保存首选项
    PreferenceUtil.putPreferenceValue(PREF_KEY, true)
    //2.跳转到首页
    this.jumpToIndex()
  }

  exitApp() {
    //退出App
    this.context.terminateSelf()
  }

  build() {
    Column({ space: 10 }) {
      Row() {
        // 1.中央slogan
        Image($r('app.media.home_slogan'))
          .width(260)
      }
      .layoutWeight(1)
      // 2.logo
      Row() {
        Image($r("app.media.app_icon"))
          .backgroundColor(Color.Blue)
          .width(30)
          .height(30)
          .border({ radius: 10 })
        Text('实战项目')
          .fontColor(Color.White)
          .fontSize(30)
          .fontWeight(FontWeight.Normal)
          .opacity(0.7)
      }
      .alignItems(VerticalAlign.Center)
      .width(150)
      // 3.文字描述
      Row() {
        Text('项目实战健康支持')
          .textStyle()
        Text('IPV6')
          .textStyle(10, 0.8)
          .fontColor(Color.White)
          .border({ style: BorderStyle.Solid, width: 1, color: Color.White, radius: 15 })
          .padding({ left: 5, right: 5 })
        Text('网络')
          .textStyle()
      }

      Text(`'减更多'是指项目实战中一款减脂软件，帮助更多用户实现身材管理`)
        .textStyle(10, 0.6)
      Text('粤ICP备000001号-001')
        .textStyle(10, 0.4)
        .margin({ bottom: 35 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ff044e96')
  }
}