
import HeadSearch from './HeadSearch'
import CardStatistic from './CardStatistic'
import RecordList from './RecordList'

@Component
export default struct RecordIndex{
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