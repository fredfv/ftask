import 'package:flutter/cupertino.dart';
import 'package:task/src/core/infra/validators/i_broadcast_controller.dart';

import '../application/broadcast_message.dart';

class BroadcastController extends IBroadcastController {
  BroadcastController();

  ValueNotifier<GetAllTasksBroadcastMessage> getAllTasksBroadcastValueNotifier =
      ValueNotifier(GetAllTasksBroadcastMessage());

  ValueNotifier<PutTaskBroadcastMessage> putTaskBroadcastValueNotifier =
      ValueNotifier(PutTaskBroadcastMessage(entity: {}));

  ValueNotifier<GetByIdBroadcastMessage> getByIdBroadcastMessage =
      ValueNotifier(GetByIdBroadcastMessage(id: ''));

  void _notify(BroadcastMessage message) {
    if (message is GetAllTasksBroadcastMessage) {
      getAllTasksBroadcastValueNotifier.value = message;
    } else if (message is PutTaskBroadcastMessage) {
      putTaskBroadcastValueNotifier.value = message;
    } else if (message is GetByIdBroadcastMessage) {
      getByIdBroadcastMessage.value = message;
    }
  }

  void onEvent(dynamic message) {
    BroadcastMessage broadcastMessage = BroadcastMessage.fromMessage(message);
    _notify(broadcastMessage);
  }
}
