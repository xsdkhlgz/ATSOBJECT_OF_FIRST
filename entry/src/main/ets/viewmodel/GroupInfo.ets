
import ItemCategory from './ItemCategory'
import RecordItem from './RecordItem'
//泛型能兼容更多类型与组内数据的使用
export default class GroupInfo<TYPE,ELEMENT> {
  //分组类型
  type:TYPE
  //组内数据集合
  items:ELEMENT[]
  //组内记录的热量总数
  calorie:number = 0

  constructor(type:TYPE,items:ELEMENT[]) {
    this.type = type
    this.items = items
  }
}