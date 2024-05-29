
import HeadSearch from './HeadSearch'
import CardStatistic from './CardStatistic'
import RecordList from './RecordList'
import RecordVO from '../../viewmodel/RecordVO'
import RecordService from '../../common/service/RecordService'
import DateUtil from '../../common/utils/DateUtil'

@Component
export default struct RecordIndex{

  //给初始化selectedDate赋值，时间为当天，这边需要过滤掉时分秒才能传过来赋值，所以使用了 DateUtil.beginTimeOfDay(new Date())
  @StorageProp('selectedDate')
  @Watch('aboutToAppear')
  selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  @Provide records:RecordVO[] = []

  async aboutToAppear(){
    this.records = await RecordService.queryRecordByDate(this.selectedDate)
  }

  build() {
    Column(){
      //1.头部搜索栏
      HeadSearch()
      //2.统计卡片
      CardStatistic()
      //3.记录列表
      RecordList()
      //它占据剩下的所有高度
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#fff0f4fc')
  }
}