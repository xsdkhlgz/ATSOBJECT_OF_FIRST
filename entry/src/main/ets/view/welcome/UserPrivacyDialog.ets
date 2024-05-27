
import {CommonConstants} from '../../common/constants/CommonConstants'

//用户隐私协议对话框
//预览
//@Preview
@CustomDialog
export default struct UserPrivacyDialog {
  controller:CustomDialogController
  confrim:()=> void
  concel:()=> void
  build() {
    Column({space:10}){
      //1.标题
      Text('欢迎使用实战项目')
        .fontSize(20)
          //字体加粗
        .fontWeight(FontWeight.Bold)
      //2.内容
      Text($r('app.string.user_privacy_content'))

      //3.按钮
      Button('同意')
        .width(150)
        .backgroundColor(Color.Blue)
        .type(ButtonType.Capsule)
        .onClick(()=>{
          this.confrim()
          this.controller.close()
        })
      Button('不同意')
        .width(150)
        .backgroundColor('#fff1e6e6')
        .fontColor('#ffb79e9e')
        .onClick(()=>{
          this.concel()
          this.controller.close()
        })


    }
    .width('100%')
    .padding(10)
  }
}