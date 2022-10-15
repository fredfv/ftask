abstract class BroadcastMessage {
  static BroadcastMessage fromMessage(dynamic message) {
    if (message[0] == 'upsertOne') {
      return PutTaskBroadcastMessage(entity: message[1]);
    } else if (message[0] == 'getAll') {
      return GetAllTasksBroadcastMessage();
    } else if (message[0] == 'getById') {
      return GetByIdBroadcastMessage(id: message[1]);
    } else {
      throw Exception('BroadcastMessage.fromMessage: message not found');
    }
  }
}

class GetAllTasksBroadcastMessage extends BroadcastMessage {
  GetAllTasksBroadcastMessage();
}

class PutTaskBroadcastMessage extends BroadcastMessage {
  final Map entity;
  PutTaskBroadcastMessage({required this.entity});
}

class GetByIdBroadcastMessage extends BroadcastMessage {
  final String id;
  GetByIdBroadcastMessage({required this.id});
}
