
import media from '@ohos.multimedia.media';
import Prompt from '@system.prompt';
@Entry
@Component
struct  AVPlayerPage{

  setAVPlayerCallback(avPlayer: media.AVPlayer) {
    // error回调监听函数,当avPlayer在操作过程中出现错误时调用reset接口触发重置流程
    avPlayer.on('error', (err) => {
      console.error(`Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`);
      avPlayer.reset(); // 调用reset重置资源，触发idle状态
    })
    // 状态机变化回调函数
    avPlayer.on('stateChange', async (state, reason) => {
      switch (state) {
        case 'idle': // 成功调用reset接口后触发该状态机上报
          console.info('AVPlayer state idle called.');
          break;
        case 'initialized': // avplayer 设置播放源后触发该状态上报
          console.info('AVPlayerstate initialized called.');
          avPlayer.prepare().then(() => {
            Prompt.showToast({
              message: '加载成功'
            })
            console.info('AVPlayer prepare succeeded.');
          }, () => {
            console.error(`Invoke prepare failed, code is , message is`);
          });
          break;
        case 'prepared': // prepare调用成功后上报该状态机
          console.info('AVPlayer state prepared called.');
          avPlayer.play(); // 调用播放接口开始播放
          break;
        case 'playing': // play成功调用后触发该状态机上报
          console.info('AVPlayer state playing called.');
          break;
        case 'paused': // pause成功调用后触发该状态机上报
          console.info('AVPlayer state paused called.');
          break;
        case 'completed': // 播放结束后触发该状态机上报
          console.info('AVPlayer state completed called.');
          avPlayer.stop(); //调用播放结束接口
          break;
        case 'stopped': // stop接口成功调用后触发该状态机上报
          console.info('AVPlayer state stopped called.');
          avPlayer.reset(); // 调用reset接口初始化avplayer状态
          break;
        case 'released':
          console.info('AVPlayer state released called.');
          break;
        default:
          console.info('AVPlayer state unknown called.');
          break;
      }
    })
  }

  build() {
    Column(){
      Button('播放').height(48).width(96)
        .onClick(()=>{
          this.playMusic();
        })
    }.justifyContent(FlexAlign.Center).align(Alignment.Center).width('100%').height('100%')
  }

  async playMusic() {
    let avPlayer: media.AVPlayer = await media.createAVPlayer();
    this.setAVPlayerCallback(avPlayer);
    avPlayer.url = "https://www.yyq.cn/audio/audiomp3/f//0b/71f/f0b71f1f52d8cc9b4238e5a1f61a7a0a.mp3"
  }
}