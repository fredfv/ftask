import 'dart:async';

import 'package:signalr_core/signalr_core.dart';

import '../../domain/services/i_hub_service.dart';
import '../application/logger.dart';
import 'broadcast_controller.dart';

class SignalRHelper implements IHubService {
  HubConnection? connection;
  BroadcastController broadcastController;

  //final StreamController<String> _streamController = StreamController<String>.broadcast();
  //get stream => _streamController.stream;

  SignalRHelper({required this.broadcastController});

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

    await connection?.start();

    connection?.onclose((_) {});

    connection?.onreconnecting((_) {});

    connection?.onreconnected((_) {});

    connection?.on('ReceiveMessage', (message) {
      forwardMessage(message);
    });
  }

  @override
  void forwardMessage(message) {
    broadcastController.onEvent(message);
  }
}
