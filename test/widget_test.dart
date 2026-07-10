import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shehmeer_portfolio/main.dart';

void main() {
  testWidgets('portfolio app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: PortfolioApp()));
    await tester.pump(const Duration(seconds: 1));

    expect(tester.takeException(), isNull);
  });
}
