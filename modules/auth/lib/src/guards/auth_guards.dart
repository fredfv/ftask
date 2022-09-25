import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/src/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    return true;
  }
}
