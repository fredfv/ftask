import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:task/app_module.dart';
import 'package:task/app_widget.dart';

void main() async {
  final connection = HubConnectionBuilder()
      .withUrl(
          'http://192.168.15.3:5002/chatHub',
          HttpConnectionOptions(
            logging: (level, message) => print(message),
          ))
      .build();

  await connection.start();

  connection.on('ReceiveMessage', (message) {
    print(message.toString());
  });

  await connection.invoke('SendMessage', args: ['Bob', 'Says hi!']);

  WidgetsFlutterBinding.ensureInitialized();

  Modular.to.addListener(() {
    if (kDebugMode) {
      print(Modular.to.path);
    }
  });

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
