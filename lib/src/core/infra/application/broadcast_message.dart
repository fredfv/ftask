abstract class BroadcastMessage {
  static BroadcastMessage fromMessage(dynamic message) {
    if (message[0] == 'uploadAll') return UploadAllTasksBroadcastMessage.fromMessage(message);
    if (message[0] == 'upsertOne') return PutTaskBroadcastMessage.fromMessage(message);
    if (message[0] == 'getById') return GetByIdBroadcastMessage.fromMessage(message);
    if (message[0] == 'getAll') return GetAllTasksBroadcastMessage();
    throw Exception('adapter not found');
  }
}

class GetAllTasksBroadcastMessage extends BroadcastMessage {
  GetAllTasksBroadcastMessage();
}

class PutTaskBroadcastMessage extends BroadcastMessage {
  final String userId;
  final Map entity;
  PutTaskBroadcastMessage({required this.userId, required this.entity});

  factory PutTaskBroadcastMessage.empty() {
    return PutTaskBroadcastMessage(userId: '', entity: {});
  }

  factory PutTaskBroadcastMessage.fromMessage(dynamic message) {
    return PutTaskBroadcastMessage(userId: message[1]['userId'], entity: message[1]['entity']);
  }
}

class GetByIdBroadcastMessage extends BroadcastMessage {
  final String id;
  GetByIdBroadcastMessage({required this.id});

  factory GetByIdBroadcastMessage.empty() {
    return GetByIdBroadcastMessage(id: '');
  }

  factory GetByIdBroadcastMessage.fromMessage(dynamic message) {
    return GetByIdBroadcastMessage(id: message[1]);
  }
}

class UploadAllTasksBroadcastMessage extends BroadcastMessage {
  final String userId;
  UploadAllTasksBroadcastMessage({required this.userId});

  factory UploadAllTasksBroadcastMessage.empty() {
    return UploadAllTasksBroadcastMessage(userId: '');
  }

  factory UploadAllTasksBroadcastMessage.fromMessage(dynamic message) {
    return UploadAllTasksBroadcastMessage(userId: message[1]);
  }
}
