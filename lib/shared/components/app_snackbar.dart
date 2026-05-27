import 'package:flutter/material.dart';

enum SnackBarType { success, error, info, warning }

class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(_iconFor(type), color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Expanded(child: Text(message, style: const TextStyle(color: Colors.white))),
          ],
        ),
        backgroundColor: _colorFor(type),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  static void showError(BuildContext context, String message) =>
      show(context, message: message, type: SnackBarType.error);

  static void showSuccess(BuildContext context, String message) =>
      show(context, message: message, type: SnackBarType.success);

  static void showInfo(BuildContext context, String message) =>
      show(context, message: message, type: SnackBarType.info);

  static void showWarning(BuildContext context, String message) =>
      show(context, message: message, type: SnackBarType.warning);

  static Color _colorFor(SnackBarType type) => switch (type) {
        SnackBarType.success => const Color(0xFF2E7D32),
        SnackBarType.error   => const Color(0xFFC62828),
        SnackBarType.warning => const Color(0xFFE65100),
        SnackBarType.info    => Colors.black87,
      };

  static IconData _iconFor(SnackBarType type) => switch (type) {
        SnackBarType.success => Icons.check_circle_outline,
        SnackBarType.error   => Icons.error_outline,
        SnackBarType.warning => Icons.warning_amber_outlined,
        SnackBarType.info    => Icons.info_outline,
      };
}
