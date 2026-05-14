import 'package:flutter/material.dart';

import '../../modules/test_c/view/screens/test_c_screen.dart';
// @provider_cli-route-import

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/test_c': (context) => const TestCScreen(),

// @provider_cli-default-route-insert
  };
}
