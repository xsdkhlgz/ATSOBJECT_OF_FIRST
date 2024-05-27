import image from '@ohos.multimedia.image'
import RecordIndex from '../view/record/RecordIndex'
import SportRecord from '../view/record/SportRecord'
import RecordOneself from '../view/record/RecordOneself'
import BreakpointSystem from '../common/utils/BreakpointSystem'
import BreakpointConstants from '../common/constants/BreakpointConstants'
import BreakpointType from '../common/bean/BreakpointType'
@Entry
@Component
struct Index {
  @State currentIndex : number = 0
  private breakpointSystem:BreakpointSystem = new BreakpointSystem()
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM

  @Builder TabBarBuilder(title:string,image:ResourceStr,index:number){
    //column上下布局  ，row左右布局
    Column({space:5}){
      Image(image)
        .width(22)
        .fillColor(this.seleceColor(index))
      Text(title)
        .fontSize(12)
        .fontColor(this.seleceColor(index))
    }
    //.justifyContent(FlexAlign.Center)
  }
  //注册
  aboutToAppear(){
    this.breakpointSystem.register()
  }
  //取消注册
  aboutToDisappear(){
    this.breakpointSystem.unregister()
  }

  seleceColor(index : number){
    return this.currentIndex === index? '#ff2cc7e2' : Color.Gray
  }

  chooseBarPosition(){
    if(this.currentBreakpoint === 'sm'){
      return BarPosition.End
    }else {
      return BarPosition.Start
    }
    let p = {
      sm:BarPosition.End,
      md:BarPosition.Start,
      lg:BarPosition.Start
    }
    return p[this.currentBreakpoint]
  }
  build() {
    //bar的位置控制：barPosition
    Tabs({barPosition:this.chooseBarPosition()}){
      //标题1
      TabContent(){
        //饮食记录
        RecordIndex()
      }
      .tabBar(this.TabBarBuilder('饮食',$r('app.media.ic_calendar'),0))
      //标题2
      TabContent(){
        //运动记录
        SportRecord()
      }
      .tabBar(this.TabBarBuilder('运动',$r('app.media.discover'),1))
      //标题3
      TabContent(){
        //个人纪录
        RecordOneself()
      }
      .tabBar(this.TabBarBuilder('个人',$r('app.media.ic_user_portrait'),2))
    }
    .width('100%')
    .height('100%')
    .onChange(index => this.currentIndex = index)
/*    .vertical({
      sm:false,
      md:true,
      lg:true
    }[this.currentBreakpoint])*/
    .vertical(new BreakpointType({
      sm:false,
      md:true,
      lg:true
    }).getvalue(this.currentBreakpoint))
  }
}