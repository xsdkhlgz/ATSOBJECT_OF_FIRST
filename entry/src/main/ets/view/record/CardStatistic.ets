import BreakpointType from '../../common/bean/BreakpointType'
import BreakpointConstants from '../../common/constants/BreakpointConstants'
import DateUtil from '../../common/utils/DateUtil'
import CalorieStats from './CalorieStats'
import DatePickDialog from './DatePickDialog'
import NutrientStat from './NutrientStat'

@Extend(Text)
function Type_of_Text(){
  .width('100%')
  .height(160)
  .textAlign(TextAlign.Center)
  .fontSize(30)
}
@Component
export default struct CardStatistic {

  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM
  //给初始化selectedDate赋值，时间为当天，这边需要过滤掉时分秒才能传过来赋值，所以使用了 DateUtil.beginTimeOfDay(new Date())
  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  controller : CustomDialogController = new CustomDialogController({
    //读取对话框里选中的日期
    builder:DatePickDialog({ selectedDate: new Date(this.selectedDate) })
  })

  build() {
    Column(){
      //日期信息
      Row(){
        //接收毫秒值
        Text(DateUtil.formatDate(this.selectedDate))
          .fontColor('#ff4dbbcd')
        Image($r('app.media.ic_public_spinner'))
          .width(20)
          .fillColor('#ff4dbbcd')
      }
      .padding(8)
      .onClick(() => {
        this.controller.open()
      })
      //统计信息
      Swiper(){
        //2.1.热量统计卡片
        CalorieStats()

        //2.2.营养素统计
        NutrientStat()
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(18)
      //穿梭框样式
      .indicatorStyle({selectedColor:'#ff2cc7e2'})
      .displayCount(new BreakpointType({
        sm:1,
        md:1,
        lg:2,
      }).getvalue(this.currentBreakpoint))
    }
    .width('94%')
    .backgroundColor('#ffc6f7ff')
    .borderRadius(18)
    //.border({radius:15})  //跟上面效果一样
  }
}