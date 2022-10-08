import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/core/domain/dictionary.dart';
import 'package:task/src/core/ui/color_outlet.dart';
import 'package:task/src/core/ui/widgets/common_scaffold.dart';

class WildcardPage extends StatelessWidget {
  const WildcardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Modular.to.navigate('/src/');
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        title: Dictionary.wildcardTitle,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '404',
                style: TextStyle(color: ColorOutlet.error, fontSize: MediaQuery.of(context).size.height * 0.1),
              ),
            ),
            Center(
              child: Text(
                'ops! I hope you are using the web page. F',
                style: TextStyle(color: ColorOutlet.secondary, fontSize: MediaQuery.of(context).size.height * 0.02),
              ),
            ),
          ],
        ));
  }
}
