import 'dart:async';

import 'package:signalr_core/signalr_core.dart';
import 'package:task/src/core/infra/logger.dart';

import '../../domain/services/hub_service.dart';

class SignalRHelper implements HubService {
  HubConnection? connection;
  final StreamController<String> _streamController = StreamController<String>.broadcast();
  get stream => _streamController.stream;

  SignalRHelper();

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
      //value = message.toString();
      _streamController.add(message.toString());
      //notifyListeners();
    });
    fLog.w('[SIGNALR CONNECTION ON MESSAGE REGISTRED]');
  }

  @override
  Future<void> sendMessage() async {
    await connection?.invoke('SendMessage', args: ['Bob', 'Eu estou bem e vc?']);
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
