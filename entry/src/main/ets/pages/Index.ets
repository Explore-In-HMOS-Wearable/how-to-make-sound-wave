import { CircularWaveAnimation } from '../components/CircularWaveAnimation'
import { LinearWaveAnimation } from '../components/LinearWaveAnimation'
import { ArcSwiper } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  build() {
    ArcSwiper() {
      LinearWaveAnimation()
      CircularWaveAnimation()
    }
  }
}