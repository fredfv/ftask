import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/core/infra/validators/i_broadcast_controller.dart';

import '../../domain/entities/user_entity.dart';
import '../application/broadcast_message.dart';

class BroadcastController extends IBroadcastController {
  BroadcastController();

  ValueNotifier<GetAllTasksBroadcastMessage> getAllTasksBroadcastValueNotifier =
      ValueNotifier(GetAllTasksBroadcastMessage());

  ValueNotifier<PutTaskBroadcastMessage> putTaskBroadcastValueNotifier = ValueNotifier(PutTaskBroadcastMessage.empty());

  ValueNotifier<GetByIdBroadcastMessage> getByIdBroadcastMessage = ValueNotifier(GetByIdBroadcastMessage.empty());

  ValueNotifier<UploadAllTasksBroadcastMessage> uploadAllTasksBroadcastMessage =
      ValueNotifier(UploadAllTasksBroadcastMessage.empty());

  void _notify(BroadcastMessage message) {
    if (message is GetAllTasksBroadcastMessage) {
      getAllTasksBroadcastValueNotifier.value = message;
    } else if (message is PutTaskBroadcastMessage) {
      putTaskBroadcastValueNotifier.value = message;
    } else if (message is GetByIdBroadcastMessage) {
      getByIdBroadcastMessage.value = message;
    } else if (message is UploadAllTasksBroadcastMessage) {
      var loggedUser = Modular.get<UserEntity>();
      if (message.userId != loggedUser.id) uploadAllTasksBroadcastMessage.value = message;
    }
  }

  void onEvent(dynamic message) {
    BroadcastMessage broadcastMessage = BroadcastMessage.fromMessage(message);
    _notify(broadcastMessage);
  }
}
