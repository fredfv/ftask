import 'package:flutter/cupertino.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:task/src/core/infra/logger.dart';

import '../hub_service.dart';

class SignalRHelper extends ValueNotifier<String> implements HubService {
  HubConnection? connection;

  SignalRHelper() : super('');

  @override
  Future<void> initConnection() async {
    fLog.w('[SIGNALR CONNECTION CREATED]');
    connection = HubConnectionBuilder()
        .withUrl(
            'http://192.168.15.3:5002/chatHub',
            HttpConnectionOptions(
                //logging: (level, message) => print(message),
                ))
        .build();
    fLog.w('[SIGNALR CONNECTION CREATED]');
    await connection?.start();
    fLog.w('[SIGNALR CONNECTION STARTED]');

    connection?.onclose((_) {
      yellsOnClose();
    });
    fLog.w('[SIGNALR CONNECTION ON CLOSE REGISTRED]');

    connection?.onreconnecting((_) {
      yellsOnReconecting();
    });
    fLog.w('[SIGNALR CONNECTION ON RECONECTING REGISTRED]');

    connection?.onreconnected((_) {
      yellsOnReconected();
    });
    fLog.w('[SIGNALR CONNECTION ON RECONECTED REGISTRED]');

    connection?.on('ReceiveMessage', (message) {
      yellsOnMessage(message);
      value = message.toString();
    });
    fLog.w('[SIGNALR CONNECTION ON MESSAGE REGISTRED]');
  }

  @override
  Future<void> sendMessage() async {
    await connection
        ?.invoke('SendMessage', args: ['Bob', 'Eu estou bem e vc?']);
    fLog.w('[SIGNALR SEND MESSAGE]');
  }

  @override
  Future<void> closeConnection() async {
    await connection?.stop();
    fLog.w('[SIGNALR ON CLOSE CONNECTION CALLED]');
  }

  @override
  void yellsOnClose() {
    fLog.w('[SIGNALR ON CLOSE YELLED]');
  }

  dynamic yellsOnReconected() {
    fLog.w('[SIGNALR ON RECONECTED YELLED]');
  }

  dynamic yellsOnReconecting() {
    fLog.w('[SIGNALR ON RECONECTING YELLED]');
  }

  @override
  dynamic yellsOnMessage(dynamic data) {
    fLog.w('[SIGNALR ON MESSAGE YELLED]');
    fLog.v(data.toString());
  }

  void checkStatus() {
    fLog.e(connection?.state);
  }
}
