import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/injection.dart';
import 'core/routes/app_routes.dart';

import 'modules/test_c/controller/test_c_controller.dart';
// @provider_cli-main-import

void main() {
  setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TestCController()),
// @provider_cli-provider-insert
      ],
      child: MaterialApp(
  debugShowCheckedModeBanner: false,
  routes: AppRoutes.routes,
)
,
    );
  }
}
