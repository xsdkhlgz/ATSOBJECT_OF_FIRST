import { CommonConstants } from '../../common/constants/CommonConstants'
@Component
export default struct NutrientStat {
  //碳水
  @Prop carbon:number
  //蛋白质
  @Prop protein:number
  //脂肪
  @Prop fat:number
  //推荐碳水摄入量
  recommendCarbon:number = CommonConstants.RECOMMEND_CARBON
  //推荐蛋白质摄入量
  recommendProtein:number = CommonConstants.RECOMMEND_PROTEIN
  //推荐脂肪摄入量
  recommendFat:number = CommonConstants.RECOMMEND_FAT

  build() {
    //行式布局
    Row({space:6}){
      //1.碳水摄入
      this.variousType({content:'碳水摄入',value:this.carbon,total:this.recommendCarbon,label:'碳水化合物',color:'green'})
      //2.蛋白质摄入
      this.variousType({content:'蛋白摄入',value:this.protein,total:this.recommendProtein,label:'蛋白质',color:'red'})
      //3.脂肪摄入
      this.variousType({content:'脂肪摄入',value:this.fat,total:this.recommendFat,label:'脂肪',color:'#ffffe71f'})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({top:30,bottom:35})
  }

  //环形进度条模板
  @Builder variousType($$:{content:string,value:number,total:number,label:string,color:ResourceStr}){
    Column(){
      //进度条
      Stack(){
        //进度条所需数据
        Progress({
          value:$$.value,
          total:$$.total,
          type:ProgressType.Ring,
        })
          .width(95)
          .style({strokeWidth:CommonConstants.DEFAULT_8})
          //进度条颜色
          .color($$.color)
        //2.2.传入各类数据
        this.StatsBuilder($$.content,$$.value,$$.total)
      }
      Text(`${$$.label}（克）`)
        .fontSize(12)
        .fontColor('#ffaca7a7')
        .padding({top:10})
    }
  }


  //进度条内内容模板
  @Builder StatsBuilder(label:string,value:number,total:number){
    Column({space:6}){
      Text(label)
        .fontSize(12)
        .fontColor('#ff9ca2a4')
      //因为value是数字，所以不能直接填写进去，需要转换类型，转成整形
      Text(`${value.toFixed(0)}/${total.toFixed(0)}`)
        .fontColor('#ff625f5f')
        .fontSize(18)
        .fontWeight(600)
    }
  }
}