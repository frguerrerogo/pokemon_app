import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test - no crash', (tester) async {
    await tester.pumpWidget(
      const SizedBox(),
    );

    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}
