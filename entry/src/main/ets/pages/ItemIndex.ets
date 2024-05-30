import router from '@ohos.router'
import { CommonConstants } from '../common/constants/CommonConstants'
import RecordService from '../common/service/RecordService'
import { RecordTypeEnum, RecordTypes } from '../model/RecordTypeModel'
import ItemCard from '../view/item/ItemCard'
import ItemList from '../view/item/ItemList'
import ItemPanelHeader from '../view/item/ItemPanelHeader'
import NumberKeyboard from '../view/item/NumberKeyboard'
import RecordItem from '../viewmodel/RecordItem'
import RecordType from '../viewmodel/RecordType'

@Entry
@Component
struct ItemIndex {
  @State amount :number = 1
  @State value :string = ''
  @State showPanel: boolean = false
  @State item:RecordItem = null
  @State type:RecordType = RecordTypes[0]
  @State isFood:boolean = true

  onPanelShow(item:RecordItem){
    this.amount = 1
    this.value = ''
    this.showPanel = true
    this.item = item
  }
  onPageShow(){
    //1.获取跳转时的参数
    let params:any = router.getParams()
    //2.获取点击的饮食记录类型
    this.type = params.type
    this.isFood = this.type.id !== RecordTypeEnum.WORKOUT
  }


  build() {
    Column(){
      //1.导航头部
      this.Header()
      //2.列表
      ItemList({showPanel:this.onPanelShow.bind(this),isFood:this.isFood})
        .layoutWeight(1)
      //3.底部面板
      Panel(this.showPanel){
        //3.1.顶部日期
        ItemPanelHeader()
        //3.2.项目信息卡片
        if(this.item){
          ItemCard({amount:this.amount,item:$item})
        }
        //3.3.数字键盘   用link传参的不能用this
        NumberKeyboard({amount:$amount,value: $value})
        //3.4.按钮
        Row(){
          Button('取消')
            .width(120)
            .backgroundColor($r('app.color.light_gray'))
            .fontColor(Color.White)
            .type(ButtonType.Normal)
            .borderRadius(10)
            .onClick(()=>{
              this.showPanel = false
            })
          Button('提交')
            .width(120)
            .backgroundColor($r('app.color.primary_color'))
            .fontColor(Color.White)
            .type(ButtonType.Normal)
            .borderRadius(10)
            .onClick(()=>{
              //1.持久化保存
              RecordService.insert(this.type.id,this.item.id,this.amount)
                .then(()=>{
                  //2.关闭弹窗
                  this.showPanel = false
                })
            })
        }
        .width('100%')
        .padding(10)
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .mode(PanelMode.Full)
      .dragBar(false)
      .backgroundMask($r('app.color.light_gray'))
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
  }

  @Builder Header(){
    //1.导航头部
    Row({space:10}){
      Image($r("app.media.ic_public_back"))
        .width(24)
        .onClick(()=>{
          router.back()
        })
      Blank()
      Text(this.type.name)
        .fontWeight(CommonConstants.FONT_WEIGHT_600)
        .fontSize(18)
    }
    .width('94%')
    .height(32)
  }
}