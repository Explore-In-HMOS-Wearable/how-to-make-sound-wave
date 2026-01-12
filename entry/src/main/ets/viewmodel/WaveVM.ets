import getRandomValue from '../utils/getRandomValue';

@Observed
export default class WaveVM {
  context: CanvasRenderingContext2D = new CanvasRenderingContext2D()
  mode: 'live' | 'random' = 'live'
  private waveData: number[] = []
  // constants
  private canvasWidth = 0
  private canvasHeight = 0
  private maxNumRect = 0
  // You can modify these values for your case
  private minValue = 1 // used if the waveData is 0
  private maxValue = 100 // used to normalize waveData
  private rectWidth = 5
  private space = 1

  start() {
    // set color
    this.context.fillStyle = '#7F00FF'
    // set constants
    this.canvasWidth = this.context.width
    this.canvasHeight = this.context.height
    this.maxNumRect = Math.floor((this.canvasWidth + this.space) / (this.rectWidth + this.space))
  }

  clear() {
    this.waveData = []
  }

  addData(num: number) {
    if (this.waveData.length === this.maxNumRect) {
      this.waveData.shift()
    }
    this.waveData.push(num)

    this.draw()
  }

  random() {
    this.waveData = new Array(this.maxNumRect).fill(0).map(() => getRandomValue() * this.maxValue)
    this.draw()
  }

  draw() {
    // first clear
    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

    const centerY = this.canvasHeight / 2
    const startX = this.canvasWidth - (this.waveData.length * this.rectWidth + (this.waveData.length - 1) * this.space)

    for (let i = 0; i < this.waveData.length; i++) {
      const rectHeight = this.normalize(this.waveData[i])
      const x = startX + i * (this.rectWidth + this.space);
      const y = centerY - rectHeight / 2;
      this.context.fillRect(x, y, this.rectWidth, rectHeight);
    }
  }

  normalize(val: number): number {
    if (val === 0) {
      return this.minValue
    }
    if (val >= this.maxValue) {
      return this.canvasHeight
    }

    return (this.canvasHeight - this.minValue) / this.maxValue * val
  }
}