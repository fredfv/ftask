import 'package:signalr_core/signalr_core.dart';

class SignalRHelper{

  final connection = HubConnectionBuilder().withUrl('https://localhost:7142/chatHub',
      HttpConnectionOptions(
        logging: (level, message) => print(message),
      )).build();



  // SignalRHelper(){
  //   connection = HubConnectionBuilder()
  //       .withUrl(
  //       hubBaseURL,
  //       HttpConnectionOptions(
  //         logging: (level, message)
  //         => print(message),
  //       )
  //   ).build();
  // }
  //
  // initiateConnection(BuildContext context) async {
  //   await connection.start();
  //
  //   connection.on("ReceiveMessage", (arguments){
  //     print(arguments);
  //     //Do what needs to be done
  //   });
  // }
  //
  // closeConnection(BuildContext context) async {
  //   if(connection.state == HubConnectionState.connected)
  //   {
  //     await connection.stop();
  //   }
  // }
}