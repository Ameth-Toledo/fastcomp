import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/network/api_client.dart';

void main() {
  final apiClient = ApiClient();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (_) => App(apiClient: apiClient),
    ),
  );
}
