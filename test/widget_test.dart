import 'package:fast_comp/app.dart';
import 'package:fast_comp/core/network/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(App(apiClient: ApiClient()));
    await tester.pumpAndSettle();
  });
}
