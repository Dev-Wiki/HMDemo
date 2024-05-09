
import socket from "@ohos.net.socket";
import { BusinessError } from '@ohos.base';
import { Log } from '@devwiki/base/Index';

class TcpSocket {
  tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
  connectOptions: socket.TCPConnectOptions = {
    address: {
      address: '172.33.108.207',
      port: 10000
    },
    timeout: 6000
  }

  constructor() {

  }

  init() {
    let messageView = '';
    this.tcp.on("message", (value: socket.SocketMessageInfo) =>{
      for (let i: number = 0; i < value.message.byteLength; i++) {
        let uint8Array = new Uint8Array(value.message)
        let messages = uint8Array[i]
        let message = String.fromCharCode(messages);
        messageView += message;
      }
      Log.i(`receive message: ${messageView}`)
    })
    this.tcp.on('error', (error) => {
      Log.i(`tcp error: ${error.message}`)
    })
  }

  connect() {
    let address: socket.NetAddress = {
      address: '172.33.108.207',
    }
    this.tcp.bind(address)
    this.tcp.connect(this.connectOptions, (error) => {
      if (error) {
        Log.e(`connect fail: ${error.message}`);
        return;
      }
      Log.i('connect success')
    })
  }

  send(text: string) {
    let option: socket.TCPSendOptions = { data: text}
    this.tcp.send(option).then(() => {
      Log.i(`send data: ${text} success`)
    }).catch((error: BusinessError) => {
      Log.e(`send data: ${text} error: ${error.message}`)
    })
  }
}


@Component
@Entry
export struct TcpSocketPage {

  tcpSocket: TcpSocket = new TcpSocket();

  aboutToAppear(): void {
    this.tcpSocket.init();
    this.tcpSocket.connect();
  }

  build() {
    Column(){
      Button("Send").width(80).height(32).onClick(() => {
        this.tcpSocket.send("test")
      })
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }
}