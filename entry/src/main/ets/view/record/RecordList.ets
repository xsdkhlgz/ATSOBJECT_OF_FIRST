import image from '@ohos.multimedia.image'
import { CommonConstants } from '../../common/constants/CommonConstants'

@Extend(Text)
function grayText(){
  .fontSize(14)
  .fontColor($r('app.color.light_gray'))
}

@Component
export default struct RecordList {
  build() {
    List({space:10}){
      ForEach([1,2,3,4,5,],(item)=>{
        ListItem(){
          Column(){
            //1.分组标题模板
            Row({space:4}){
              Image($r('app.media.ic_breakfast'))
                .width(24)
              Text('早餐')
                .fontSize(18)
                .fontWeight(CommonConstants.FONT_WEIGHT_700)
              Text('建议423-592千卡')
                .grayText()
              Blank()
              Text('190')
                .fontColor($r('app.color.primary_color'))
                .fontSize(14)
              Text('千卡')
                .grayText()
              Image($r('app.media.ic_public_add_norm_filled'))
                .width(20)
                .fillColor($r('app.color.primary_color'))
            }
            .width('100%')
            //2.组内纪录列表
            List(){
              ForEach([1,2],(item)=>{
                ListItem(){
                  Row({space:CommonConstants.SPACE_6}){
                    Image($r('app.media.toast'))
                      .width(50)
                    Column({space:CommonConstants.SPACE_4}){
                      Text('全麦吐司')
                        .fontWeight(CommonConstants.FONT_WEIGHT_500)
                      Text('1片')
                        .grayText()
                    }
                    Blank()
                    Text('91千卡')
                      .grayText()
                  }
                  .width('100%')
                  .padding(6)
                }
                //侧滑删除效果
                .swipeAction({end:this.deleteButton.bind(this)})
              })
            }
            .width('100%')
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(18)
          .padding(12)
        }
      })
      }
    .margin({top:10})
    .width('94%')
    .height('100%')
    }

  //删除按钮
  @Builder deleteButton(){
    Image($r('app.media.ic_public_delete_filled'))
      .width(20)
      .height(20)
      .fillColor(Color.Red)
      .margin(5)
  }


//1.分组标题列表模板
  @Builder FoodType(meal:string,range1:number = 423,range2:number = 592,energy:number,){
    Column(){
      Row({space:4}){
        Image($r('app.media.ic_breakfast'))
          .width(24)
        Text(meal)
          .fontSize(18)
          .fontWeight(CommonConstants.FONT_WEIGHT_700)
        Text(`建议${range1}-${range2}千卡`)
          .grayText()
        Blank()
        Text(energy.toFixed(0))
          .fontColor($r('app.color.primary_color'))
          .fontSize(14)
        Text('千卡')
          .grayText()
        Image($r('app.media.ic_public_add_norm_filled'))
          .width(20)
          .fillColor($r('app.color.primary_color'))
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(18)
    .padding(12)
  }

  //2.组内记录列表模板
  @Builder List_of_Team(){
    Row({space:CommonConstants.SPACE_6}){
      Image($r('app.media.toast'))
        .width(50)
      Column({space:CommonConstants.SPACE_4}){
        Text('全麦吐司')
          .fontWeight(CommonConstants.FONT_WEIGHT_500)
        Text('1片')
          .grayText()
      }
      Blank()
      Text('91千卡')
        .grayText()
    }
    .width('100%')
    .padding(6)
  }
  }



