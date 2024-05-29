
import ItemModel from '../../model/ItemModel'
import RecordModel from '../../model/RecordModel'
import { RecordTypes, RecordTypeEnum} from '../../model/RecordTypeModel'
import GroupInfo from '../../viewmodel/GroupInfo'
import RecordType from '../../viewmodel/RecordType'
import RecordVO from '../../viewmodel/RecordVO'
import StatsInfo from '../../viewmodel/StatsInfo'
import RecordPO from '../bean/RecordPO'
import DateUtil from '../utils/DateUtil'

class RecordService{
  /**
   * 新增饮食记录
   * @param typeId 记录类型id
   * @param itemId 记录项id
   * @param amount 记录项数量（食物量、运动时长）
   * @returns 新增数量
   */
  insert(typeId:number,itemId:number,amount:number){
    //1.获取时间
    let createTime = (AppStorage.Get('selectedDate') || DateUtil.beginTimeOfDay(new Date())) as number
    //2.新增
    return RecordModel.insert({typeId,itemId,amount,createTime})
  }

  deleteById(id:number){
    return RecordModel.deleteById(id)
  }

  async queryRecordByDate(date:number):Promise<RecordVO[]>{
    //1.查询数据库的RecordPO
    let recordPo = await RecordModel.queryByDate(date)
    //2.将RecordPO转为1RecordVO

    return recordPo.map(rp =>{
      //2.1获取po中的基本属性
      let rv = {id:rp.id,typeId:rp.typeId,amount:rp.amount} as RecordVO
      //2.2.查询记录项
      //没明白，这时候不应该是传布尔值来确定是否为食物或者运动吗，typeid和workout是怎么能够相等的
      rv.recordItem = ItemModel.getById(rp.itemId,rp.typeId !== RecordTypeEnum.WORKOUT)
      //2.3.计算热量
      rv.calorit = rp.amount *rv.recordItem.calorie
      return rv
    })
  }

  calculateStatsInfo(record:RecordVO[],):StatsInfo{
    //1.准备结果
    let info = new StatsInfo()
    if(!record || record.length <= 0){
      return info
    }
    //2.计算统计数据
    record.forEach((records => {
      if(records.typeId ===RecordTypeEnum.WORKOUT){
        //运动，累加消耗热量
        info.expend += records.calorit
      }else{
        //食物，累加摄入热量，蛋白质，碳水，脂肪
        info.intake += records.calorit
        info.carbon += records.recordItem.carbon
        info.protein +=records.recordItem.protein
        info.fat += records.recordItem.fat
      }
    }))
    //3.返回
    return info
  }

  calculateGroupInfo(record:RecordVO[],):GroupInfo<RecordType,RecordVO>[]{
    //1.创建空记录类型分组
    let groups = RecordTypes.map(RecordType => new GroupInfo(RecordType,[]))
    if(!record || record.length <= 0){
      return groups
    }
    //2.遍历所有饮食记录，
    record.forEach(record =>{
      //2.1.将每个记录存入对应类型的分组中
      groups[record.typeId].items.push(record)
      //2.2.计算该组的总热量
      groups[record.typeId].calorie += record.calorit
    })

    return groups
  }


}

let recordService = new RecordService()

export default recordService as RecordService