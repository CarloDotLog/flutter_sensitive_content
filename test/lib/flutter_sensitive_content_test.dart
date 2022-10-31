import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../example/lib/main.dart';

void main() {
  testWidgets('AppLifecycleStateChanged smoke test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that 'Sensitive Data' is printed at start.
    expect(find.text('Sensitive Data'), findsOneWidget);
    expect(find.text('Public Data'), findsNothing);

    // change AppLifecycleState to AppLifecycleState.paused
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();

    // Verify that 'Public Data' is printed on AppLifecycleState.paused.
    expect(find.text('Sensitive Data'), findsNothing);
    expect(find.text('Public Data'), findsOneWidget);

    // change AppLifecycleState to AppLifecycleState.resumed
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();

    // Verify that 'Sensitive Data' is printed at start.
    expect(find.text('Sensitive Data'), findsOneWidget);
    expect(find.text('Public Data'), findsNothing);
  });
}
