import 'package:flutter/cupertino.dart';
import 'package:task/src/core/domain/services/validators/i_broadcast_controller.dart';

import '../application/broadcast_message.dart';

class BroadcastController extends IBroadcastController {
  BroadcastController();

  ValueNotifier<GetAllTasksBroadcastMessage> getAllTasksBroadcastValueNotifier =
      ValueNotifier(GetAllTasksBroadcastMessage());

  void _notify(BroadcastMessage message) {
    if (message is GetAllTasksBroadcastMessage) {
      getAllTasksBroadcastValueNotifier.value = message;
    }
  }

  void onEvent(dynamic message) {
    BroadcastMessage broadcastMessage = BroadcastMessage.fromMessage(message);
    _notify(broadcastMessage);
  }
}
