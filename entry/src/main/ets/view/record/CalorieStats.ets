import { CommonConstants } from '../../common/constants/CommonConstants'
@Component
export default struct CalorieStats {
  //摄入量
  @Prop intake:number
  //运动消耗
  @Prop expend:number
  //各类参数成人推荐摄入量设置为常量
  recommend:number = CommonConstants.RECOMMEND_CALORIE
  remainCalorie(){
    return this.recommend - this.intake + this.expend
  }
  build() {
    //行式布局
    Row({space:6}){
      //1.饮食摄入
      this.StatsBuilder({label:'饮食摄入',value:this.intake})
      //2.仍能摄入
      Stack(){
        //2.1.进度条
        Progress({
          value:this.intake,
          total:this.recommend + this.expend,
          type:ProgressType.Ring,

        })
          .width(120)
          .style({strokeWidth:CommonConstants.DEFAULT_10})
        //2.2.统计数据
        this.StatsBuilder({label:'仍能摄入',value:this.remainCalorie(),tips:`推荐${this.recommend}`})
      }
      //3.运动消耗
      this.StatsBuilder({label: '运动消耗',value:this.expend})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({top:30,bottom:35})
  }

  @Builder StatsBuilder($$:{label:string,value:number,tips?:string}){
    Column({space:6}){
      Text($$.label)
        .fontColor('#ffa2adb8')
        .fontWeight(600)
      //因为value是数字，所以不能直接填写进去，需要转换类型，转成整形
      Text($$.value.toFixed(0))
        .fontColor('#ff625f5f')
        .fontSize(20)
        .fontWeight(700)
      Text($$.tips)
        .fontSize(12)
        .fontColor('app.color.light_gray')

    }
  }
}