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
      body: Row(
          children: [
            Container(
              color: Colors.grey[200],
              width: MediaQuery.of(context).size.width * 0.2,
              child: NavigationListener(
                builder: (context, widget) {
                  return Column(
                    children: [
                      ListTile(
                      title: const Text('Red'),
                      selected: Modular.to.path.endsWith('/red'),
                      onTap: (){
                        Modular.to.navigate('./red');
                      },),
                      ListTile(title: const Text('Blue'),
                      selected: Modular.to.path.endsWith('/blue'),
                      onTap: (){
                        Modular.to.navigate('./blue');
                      },),
                      ListTile(title: const Text('Yellow'),
                      selected: Modular.to.path.endsWith('/yellow'),
                        onTap: (){
                          Modular.to.pushNamed('./yellow', forRoot: true);
                        },
                      )
                    ],
                  );
                }
              ),
            ),
            const Expanded(child: RouterOutlet())
          ],
      ),
    );
  }
}
