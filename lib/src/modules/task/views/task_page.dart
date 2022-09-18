import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task page'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              //Modular.to.pushNamed('./list?id=1');
              //Modular.to.pushNamed('./list/2');
              Modular.to.pushNamed('./list', arguments: '3');
            },
            child: const Text('Listar task')),
      ),
    );
  }
}
