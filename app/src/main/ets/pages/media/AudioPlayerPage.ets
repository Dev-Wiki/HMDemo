import audio from '@ohos.multimedia.audio';
import { BusinessError } from '@ohos.base';
import fs from '@ohos.file.fs';

const TAG = 'AudioRendererDemo';

class Options {
  offset?: number;
  length?: number;
}

let context = getContext(this);
let bufferSize: number = 0;
let renderModel: audio.AudioRenderer | undefined = undefined;
let audioStreamInfo: audio.AudioStreamInfo = {
  samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_48000, // 采样率
  channels: audio.AudioChannel.CHANNEL_2, // 通道
  sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE, // 采样格式
  encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW // 编码格式
}

let audioRendererInfo: audio.AudioRendererInfo = {
  usage: audio.StreamUsage.STREAM_USAGE_MUSIC, // 音频流使用类型
  rendererFlags: 0 // 音频渲染器标志
}

let audioRendererOptions: audio.AudioRendererOptions = {
  streamInfo: audioStreamInfo,
  rendererInfo: audioRendererInfo
}

let writeDataCallback = (buffer: ArrayBuffer) => {
  let raw = $rawfile('yangzhou.amr')
  let path = getContext().resourceManager.getRawFile('').then((file) => {
  })
  //确保该路径下存在该资源
  let filePath = path + '/StarWars10s-2C-48000-4SW.wav';
  let file: fs.File = fs.openSync(filePath, fs.OpenMode.READ_ONLY);
  let options: Options = {
    offset: bufferSize,
    length: buffer.byteLength
  }
  fs.readSync(file.fd, buffer, options);
  bufferSize += buffer.byteLength;
}

// 初始化，创建实例，设置监听事件
function init() {
  audio.createAudioRenderer(audioRendererOptions, (err, renderer) => { // 创建AudioRenderer实例
    if (!err) {
      console.info(`${TAG}: creating AudioRenderer success`);
      renderModel = renderer;
      if (renderModel !== undefined) {
        (renderModel as audio.AudioRenderer).on('writeData', writeDataCallback);
      }
    } else {
      console.info(`${TAG}: creating AudioRenderer failed, error: ${err.message}`);
    }
  });
}

// 开始一次音频渲染
function start() {
  if (renderModel !== undefined) {
    let stateGroup = [audio.AudioState.STATE_PREPARED, audio.AudioState.STATE_PAUSED, audio.AudioState.STATE_STOPPED];
    if (stateGroup.indexOf((renderModel as audio.AudioRenderer).state.valueOf()) === -1) { // 当且仅当状态为prepared、paused和stopped之一时才能启动渲染
      console.error(TAG + 'start failed');
      return;
    }
    // 启动渲染
    (renderModel as audio.AudioRenderer).start((err: BusinessError) => {
      if (err) {
        console.error('Renderer start failed.');
      } else {
        console.info('Renderer start success.');
      }
    });
  }
}

// 暂停渲染
function pause() {
  if (renderModel !== undefined) {
    // 只有渲染器状态为running的时候才能暂停
    if ((renderModel as audio.AudioRenderer).state.valueOf() !== audio.AudioState.STATE_RUNNING) {
      console.info('Renderer is not running');
      return;
    }
    // 暂停渲染
    (renderModel as audio.AudioRenderer).pause((err: BusinessError) => {
      if (err) {
        console.error('Renderer pause failed.');
      } else {
        console.info('Renderer pause success.');
      }
    });
  }
}

// 停止渲染
async function stop() {
  if (renderModel !== undefined) {
    // 只有渲染器状态为running或paused的时候才可以停止
    if ((renderModel as audio.AudioRenderer).state.valueOf() !== audio.AudioState.STATE_RUNNING && (renderModel as audio.AudioRenderer).state.valueOf() !== audio.AudioState.STATE_PAUSED) {
      console.info('Renderer is not running or paused.');
      return;
    }
    // 停止渲染
    (renderModel as audio.AudioRenderer).stop((err: BusinessError) => {
      if (err) {
        console.error('Renderer stop failed.');
      } else {
        console.info('Renderer stop success.');
      }
    });
  }
}

// 销毁实例，释放资源
async function release() {
  if (renderModel !== undefined) {
    // 渲染器状态不是released状态，才能release
    if (renderModel.state.valueOf() === audio.AudioState.STATE_RELEASED) {
      console.info('Renderer already released');
      return;
    }
    // 释放资源
    (renderModel as audio.AudioRenderer).release((err: BusinessError) => {
      if (err) {
        console.error('Renderer release failed.');
      } else {
        console.info('Renderer release success.');
      }
    });
  }
}

@Entry
@Component
struct AudioPlayerPage {

  build() {
  }
}