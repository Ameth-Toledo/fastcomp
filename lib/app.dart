import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/navigation/app_router.dart';
import 'core/navigation/app_routes.dart';
import 'core/network/api_client.dart';

class App extends StatelessWidget {
  final ApiClient apiClient;

  const App({super.key, required this.apiClient});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'FastComp',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: AppRoutes.login,
      routes: AppRouter.routes(apiClient),
    );
  }
}
