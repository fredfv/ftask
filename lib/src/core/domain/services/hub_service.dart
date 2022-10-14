abstract class HubService {
  Future<void> initConnection();

  void forwardMessage(dynamic message);
}
