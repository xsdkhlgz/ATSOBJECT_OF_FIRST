
import { CommonConstants } from '../../common/constants/CommonConstants'
import RecordItem from '../../../ets/viewmodel/RecordItem'
import ItemModel from '../../model/ItemModel'
import GroupInfo from '../../viewmodel/GroupInfo'
import ItemCategory from '../../viewmodel/ItemCategory'


@Component
export default struct ItemList {

  showPanel: () => void
  //声明一个状态变量，因为传过来的参数主要取决于用户的需求
  @State isFood:boolean = true

  build() {
    Tabs(){
      TabContent(){
        this.Type_of_Food(ItemModel.list(this.isFood))
      }
      .tabBar('全部')
      ForEach(ItemModel.listItemGroupByCategory(this.isFood),(group:GroupInfo)=>{
        TabContent(){
          this.Type_of_Food(group.items)
        }
        .tabBar(group.type.name)
      })
    }
    .width('94%')
    .height('100%')

  }

  @Builder Type_of_Food(items:RecordItem[]){
    List({space:CommonConstants.SPACE_10}){
      ForEach(items,(item:RecordItem)=>{
        ListItem(){
          Row({space:CommonConstants.SPACE_6}){
            Image(item.image)
              .width(50)
            Column({space:CommonConstants.SPACE_4}){
              Text(item.name)
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
              Text(`${item.calorie}千卡/${item.unit}`)
                .fontSize(14)
                .fontColor($r('app.color.light_gray'))
            }
            Blank()
            Image($r('app.media.ic_public_add_norm_filled'))
              .width(18)
              .fillColor($r('app.color.primary_color'))
          }
          .width('100%')
          .padding(6)
        }
        .onClick(()=>{
          this.showPanel()
        })
      })
    }
    .width('100%')
    .height('100%')
  }

}function itemmodel(itemmodel: any) {
throw new Error('Function not implemented.')
}
