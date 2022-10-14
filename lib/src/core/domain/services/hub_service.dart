abstract class HubService {
  Future<void> initConnection();

  Future<void> sendMessage();

  Future<void> closeConnection();

  void yellsOnClose();

  dynamic yellsOnMessage(dynamic data);
}
