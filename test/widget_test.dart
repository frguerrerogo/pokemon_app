import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/main.dart';

void main() {
  testWidgets('Smoke test - app starts', (tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.text('Pokemon App'), findsOneWidget);
  });
}
