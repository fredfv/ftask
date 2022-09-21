import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/app_module.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState(){
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((_) async{
      await Modular.isModuleReady<AppModule>();
      Modular.to.navigate('/src/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      child: const Center(
        child: CircularProgressIndicator(
        ),
      ),
    );
  }
}
