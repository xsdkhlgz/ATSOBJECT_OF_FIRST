
/*不是component ，吃了大亏，一定要再仔细一点，但有一点不明白的就是将CustomDialog
替换成component就会报错到底是什么原因*/
@CustomDialog
export default struct DatePickDialog {
  //对话框的开发不能漏掉下面这句
  controller: CustomDialogController
  selectedDate: Date = new Date()

  build() {
    Column({ space: 12 }) {
      //1.日期选择器
      DatePicker({
        start: new Date('2020-01-01'),
        end: new Date('2100-01-01'),
        selected: this.selectedDate
      })
        .onChange((value: DatePickerResult) => {
          this.selectedDate.setFullYear(value.year, value.month, value.day)
          console.info('select current date is :' + JSON.stringify(value))
        })

      //2.按钮
      Row({ space: 12 }) {
        //取消按钮
        Button('取消')
          .type(ButtonType.Capsule)
          .fontColor('#ffffff')
          .backgroundColor('#f1f1f1')
          .width(120)
          .onClick(() => {
            //点击取消按钮退出界面
            this.controller.close()
          })
        //确定按钮
        Button('确定')
          .type(ButtonType.Capsule)
          .fontColor('#ffffff')
          .backgroundColor('#ff66dbee')
          .width(120)
          .onClick(() => {
            /*1.将日期保存至全局存储，存储的时候不要将日期date对象存进去，因为在未来作状态变量监控的时候会出问题；
            所以要加getTime()转换成毫秒值再进行存储*/
            AppStorage.SetOrCreate('selectedDate', this.selectedDate.getTime())
            //2.关闭窗口
            this.controller.close()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
    //内边距
    .padding(12)
    .borderRadius(15)
  }
}