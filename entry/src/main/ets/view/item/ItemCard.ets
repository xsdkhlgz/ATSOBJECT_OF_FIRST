import { CommonConstants } from '../../common/constants/CommonConstants'
import RecordItem from '../../viewmodel/RecordItem'
import NutrientStat from '../record/NutrientStat'
@Component
export default struct ItemCard {

  @Prop amount:number
  @Link item:RecordItem

  build() {
    Column({space:CommonConstants.SPACE_8}){
      //1.图片
      Image(this.item.image)
        .width(150)
      //2.名称
      Row(){
        Text(this.item.name)
          .fontWeight(CommonConstants.FONT_WEIGHT_700)
      }
      .backgroundColor($r('app.color.lightest_primary_color'))
      .padding({top:5,bottom:5,left:12,right:12})
      Divider()
      .width(CommonConstants.THOUSANDTH_940)
        //透明度
      .opacity(0.6)
      //3.营养素信息
      Row({space:CommonConstants.SPACE_8}){
        this.NutrientInfo({label:'热量(千卡)',value:this.item.calorie})
        if(this.item.id < 10000){
          this.NutrientInfo({label:'碳水(克)',value:this.item.carbon})
          this.NutrientInfo({label:'蛋白质(克)',value:this.item.protein})
          this.NutrientInfo({label:'脂肪(克)',value:this.item.fat})
        }
      }
      Divider()
        .width(CommonConstants.THOUSANDTH_940)
          //透明度
        .opacity(0.6)
      //4.数量
      Row(){
        Column({space:4}){
          Text(this.amount.toFixed(1))
            .fontSize(50)
            .fontColor($r('app.color.primary_color'))
            .fontWeight(CommonConstants.FONT_WEIGHT_600)
          Divider()
            .color($r('app.color.primary_color'))
        }
        .width(150)
        Text(this.item.unit)
          .fontColor($r('app.color.light_gray'))
          .fontWeight(CommonConstants.FONT_WEIGHT_600)
      }

    }
  }

  @Builder NutrientInfo($$:{label:string,value:number}){
    Column({space:8}){
      Text($$.label)
        .fontColor($r('app.color.light_gray'))
        .fontSize(14)
      Text(($$.value * this.amount).toFixed(1))
        .fontSize(18)
        .fontWeight(CommonConstants.FONT_WEIGHT_700)
    }
  }
}