// // chat service has socketio server and chat functionality rolled into one.
// @Injectable({
//     providedIn: 'root'
//   })
// export class SocketioService {
//   private socket: Socket;
//   private messageSocket: Socket;
//   private uploadSocket: Socket;

//   constructor() {
//     // initializes the socket.io client
//     this.socket = io(environment.WebSocketHost, {
//         path: '/socket.io',
//         transports: ['websocket','polling'], // Use WebSocket transport
//     });
//     this.messageSocket = io(environment.WebSocketHost+"/messages", {
//       path: '/socket.io',
//       transports: [ 'websocket','polling'], // Use WebSocket transport
//     });
//       this.uploadSocket = io(environment.WebSocketHost, {
//         path: '/socket.io',
//         transports: [ 'websocket','polling'], // Use WebSocket transport
//     });
//    }

//     //   returns message updates from the database for chat functionality
//     onNewMessage(): Observable<any> {
//         return new Observable(observer => {
//         this.messageSocket.on('message_update', data => observer.next(data));
//         });
//     }

//     //   updating status for EDMS uploads
//     onNewDocUpdate(): Observable<any> {
//       return new Observable(observer => {
//         this.uploadSocket.on('fileuploadstatusdata', data => observer.next(data));
//         });
//     }
// }