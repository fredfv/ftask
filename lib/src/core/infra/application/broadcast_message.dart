abstract class BroadcastMessage {
  static BroadcastMessage fromMessage(dynamic message) {
    //aqui eu consigo saber qual tipo message chegou e definir qual broadcastMessage eu devo retornar
    //criar tambem um value notifier para cada tipo de broadcastMessage
    return GetAllTasksBroadcastMessage();
  }
}

class GetAllTasksBroadcastMessage extends BroadcastMessage {
  GetAllTasksBroadcastMessage();
}
