
import ItemCategory from './ItemCategory'
import RecordItem from './RecordItem'
export default class GroupInfo {
  //分组类型
  type:ItemCategory
  //组内数据集合
  items:RecordItem[]

  constructor(type:ItemCategory,items:RecordItem[]) {
    this.type = type
    this.items = items
  }
}