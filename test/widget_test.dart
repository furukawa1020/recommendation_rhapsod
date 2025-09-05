// test/widget_test.dart

import 'package:flutter_test/flutter_test.dart';

// main.dartをインポートして、アプリのメインクラスを使用可能にします。
import 'package:flutter_application_4/main.dart';

void main() {
  testWidgets('App starts with Recommendations page', (WidgetTester tester) async {
    // テスト対象のウィジェットをビルドします。
    await tester.pumpWidget(const RecommendationApp());

    // ウィジェットツリー内で特定のテキストを検索します。
    expect(find.text('Recommendations for You'), findsOneWidget);
  });
}
