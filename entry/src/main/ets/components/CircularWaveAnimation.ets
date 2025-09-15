import { ArcButton, ArcButtonOptions, ArcButtonPosition } from "@ohos.arkui.advanced.ArcButton";
import CircularWaveVM from "../viewmodel/CircularWaveVM";

@Component
export struct CircularWaveAnimation {
  @State waveVm: CircularWaveVM = new CircularWaveVM()
  private intervalId: number | null = null;

  build() {
    Stack() {
      Canvas(this.waveVm.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.waveVm.start()

          this.intervalId = setInterval(() => {
            this.waveVm.addData(Math.random() * 100)
          }, 100)
        })

      Column() {
        Text(this.waveVm.mode === 'live' ? 'Live' : 'Random').fontSize(18).padding({ top: 4 })

        Blank().layoutWeight(1)

        ArcButton({
          options: new ArcButtonOptions({
            position: ArcButtonPosition.BOTTOM_EDGE,
            label: 'Change Mode',
            onClick: () => {
              clearInterval(this.intervalId)

              if (this.waveVm.mode === 'live') {
                this.waveVm.mode = 'random'
                this.intervalId = setInterval(() => {
                  this.waveVm.random()
                }, 100)
              } else {
                this.waveVm.mode = 'live'
                this.waveVm.clear()
                this.intervalId = setInterval(() => {
                  this.waveVm.addData(Math.random() * 100)
                }, 100)
              }
            }
          })
        })
      }
    }.size({ width: '100%', height: '100%' })
  }
}