import Prompt from '@system.prompt';


@Component
export default struct HeadSearch {
  Interface_MailBox(value: string) {
    Prompt.showToast({
      message: value
    })
  }

  build() {
    Row({ space: 8 }) {
      Search({
        placeholder: '搜索饮食或运动信息'
      })
        .textFont({ size: 18 })
          //占据剩下的所有宽度
        .layoutWeight(1)
      //邮件件数角标
      Badge({ count: 1, style: { fontSize: 10 }, position: BadgePosition.RightTop }) {
        Image($r('app.media.ic_public_email'))
          .width(24)
          .onClick(() => {
            //console.log('接口未写')
            this.Interface_MailBox('接口未写')
          })
      }
    }
    .width('94%')
  }
}