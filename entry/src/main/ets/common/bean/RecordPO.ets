
export default class RecordPO{
  //记录id
  id?:number
  //饮食记录类型
  typeId:number
  //记录中的食物或运动信息
  itemId:number
  //食物数据或运动时长，如果是运动信息则无
  amount:number = 0
  //记录日期
  createTime:number

}