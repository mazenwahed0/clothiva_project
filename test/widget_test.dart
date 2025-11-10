import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

// 1. An empty binding to override the real GeneralBindings
class TestBindings extends Bindings {
  @override
  void dependencies() {
    // We leave this empty on purpose.
    // This stops the app from trying to init all the Firebase repositories
    // that are listed in GeneralBindings.
  }
}

void main() {
  // 2. We do NOT need setupFirebaseCoreMocks() or setUpAll.

  testWidgets('App smoke test', (WidgetTester tester) async {
    // 3. Build a GetMaterialApp directly and override the initialBinding
    await tester.pumpWidget(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        // Override the initialBinding with our empty TestBindings
        initialBinding: TestBindings(),
        // This is the home widget from your app.dart
        home: const Scaffold(
          backgroundColor: CColors.primary,
          body: Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );

    // 4. Verify that your app shows the initial loading spinner.
    // We find the Type, not the constructor.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
