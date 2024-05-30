
import Prompt from '@system.prompt';
import router from '@ohos.router';
import common from '@ohos.app.ability.common';
import Want from '@ohos.app.ability.Want';


/*和@Styles不同，@Extend仅支持定义在全局，不支持在组件内部定义。和@Styles不同，
@Extend支持封装指定组件的私有属性、私有事件和自身定义的全局方法。*/
@Extend(TextInput)
function InputStyle(){
    .placeholderColor('#99182431')
    .height(45)
    .fontSize(18)
    .backgroundColor('#f1f3f5')
    .width("100%")
    .padding({ left:0 })
    .margin({ top: 12 })
}
@Extend(Line)
function LineStyle(){
  .width("100%")
  .height(1)
  .backgroundColor('#330b509b')
}
@Extend(Text)
function TextStyle(){
  .fontWeight(FontWeight.Medium)
  .fontSize(16)
  .fontColor('#bc5b7fea')
  .margin({left:10,right:10})
}
@Extend(Image)
function App_Icon(){
  .width(32)
  .height(32)
}

@Entry
@Component
struct Page_of_First{
  @State account: string = '';
  @State password: string = '';
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1;

  //1、跳转文档的第一步； as是类型强制转换的意思
  private context = getContext(this) as common.UIAbilityContext

  login(): void {
     if(this.account ==='' ||this.password ==='') {
       this.Interface_Login('账号密码不能为空')
     }else {
      /* this.isShowProgress = true;
       if(this.timeOutId=== -1){
         setTimeout(()=>{
           this.isShowProgress = false;
           router.pushUrl({url:'pages/Index'});
         })
       }*/
       router.pushUrl({url:'pages/Index'});
     }
  }

  Interface_Login(value:string){
    Prompt.showToast({
      message:value
    })
  }

  build(){
    Column(){
      //首页图标logo
      Image($r("app.media.ic_main"))
        .width(78)
        .height(78)

        .margin({top:100,bottom:8})
        .borderRadius(25)
      //登录界面文字
      Text('登录logo')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
      Text('登录账号以使用更多服务')
        .fontColor('#3316202b')
        .padding({top:10,bottom:30})
      //账号填写栏
      TextInput({placeholder:'账号/手机号'})
        .maxLength(11)
        .type(InputType.Number)
        .InputStyle()
        .onChange(
          (value:string)=>{
            this.account = value
        })
      //账号填写栏的下划线
      Line()
        .LineStyle()
      //密码
      TextInput({placeholder:'密码'})
        .maxLength(8)
        .type(InputType.Password)
        .InputStyle()
        .onChange(
          (value:string)=>{
            this.password = value
          }
        )
      //账号填写栏的下划线
      Line()
        .LineStyle()
      Row({space:10}){
        Text('短信验证码登录')
          .TextStyle()
          .onClick(()=>{
            this.Interface_Login('未做相关接口')
          })

        Text('忘记密码')
          .TextStyle()
          .onClick(()=>{
            this.Interface_Login('未做相关接口')
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({top:8})

      //按钮
      Button('登录')
        .type(ButtonType.Capsule)
        .width('90%')
        .fontSize(16)
        .height(48)  //按钮本身的高度
        .fontWeight(FontWeight.Medium)
        .margin({top:87,bottom:12})
        .onClick(()=>{
          this.login()
        })
      //注册账号
      Text('注册账号')
/*        .fontColor('#007dff')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)*/
        .TextStyle()
        //注册账号
        .onClick(()=>{
          this.Interface_Login('未做相关接口')
        })

      Blank()

      //其它登录方式
      Text('其他登录方式')
        .fontColor('#838d97')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({top:50,bottom:12})
      //登陆方式图标
      Row(){
        Image($r('app.media.huawei_logo'))
          .App_Icon()
          .onClick(()=>{
            this.Interface_Login('未做相关接口')

            //跳转到文档编辑的UIAbility
            //2、第二步，跳转的目的地want
            let want : Want = {
              deviceId: '',  //为空就表示当前设备
              bundleName: 'com.example.myapplication',  //表示需要跳转到哪个应用，如果是当前应用就直接复制app.json5上的bundlename即可
              moduleName:'entry',        //表示你要跳到哪个模块，如果是当前模块就查看module.json5文件的modulename即可
              abilityName:'Page_of_First_Ability',  //你要跳到哪个ability去，
              parameters:{
                instanceKey:'123'
              }
            }

            //跳转
            this.context.startAbility(want)

          })
        Image($r('app.media.weixin_logo'))
          .App_Icon()
          .onClick(()=>{
            this.Interface_Login('未做相关接口')
          })
        Image($r('app.media.qq_logo'))
          .App_Icon()
          .onClick(()=>{
            this.Interface_Login('未做相关接口')
          })
      }
      .width('100%')
      //.margin({left:20,right:20})
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width("100%")
    .height("100%")
    .alignItems(HorizontalAlign.Center)
    //.backgroundColor('#f1f3f5')
    .padding({
      left:12,
      right:12,
      bottom:24
    })
  }
}


