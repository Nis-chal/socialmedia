import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:socialmedia/screens/loginScreen.dart';
import 'package:socialmedia/screens/registerScreen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("testing the widgets", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
      },
      home: RegisterScreen(),
    ));
    Finder name = find.byKey(const ValueKey("name"));
    await tester.enterText(name, "Merry");

    Finder location = find.byKey(const ValueKey("location"));
    await tester.enterText(location, "New York");

    Finder email = find.byKey(const ValueKey("email"));
    await tester.enterText(email, "Merry2@gmail.com");

    Finder password = find.byKey(const ValueKey("password"));
    await tester.enterText(password, "Merry2@79789");
    Finder signup = find.byKey(const ValueKey("Register"));
    await tester.dragUntilVisible(
      signup,
      find.byType(Scaffold),
      const Offset(0, 70),
    );
    await tester.tap(signup);
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsOneWidget);
  });



   testWidgets("testing login ", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
      },
      home: RegisterScreen(),
    ));
 

    Finder email = find.byKey(const ValueKey("email"));
    await tester.enterText(email, "Merry2@gmail.com");

    Finder password = find.byKey(const ValueKey("password"));
    await tester.enterText(password, "Merry2@79789");
    Finder signup = find.byKey(const ValueKey("Register"));
    await tester.dragUntilVisible(
      signup,
      find.byType(Scaffold),
      const Offset(0, 70),
    );
    await tester.tap(signup);
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
