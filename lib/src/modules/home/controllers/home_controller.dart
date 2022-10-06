import 'package:flutter/cupertino.dart';

import '../../../core/services/websocket/signalr_helper.dart';

class HomeController extends ChangeNotifier{

  final SignalRHelper hub;
  HomeController({required this.hub});

}