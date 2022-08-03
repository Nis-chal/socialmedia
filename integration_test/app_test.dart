import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:socialmedia/screens/loginScreen.dart';
import 'package:socialmedia/screens/registerScreen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("testing the register", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
      },
      home: RegisterScreen(),
    ));
    Finder name = find.byKey(const ValueKey("name"));
    await tester.enterText(name, "Merryjjkkk");
    Finder username = find.byKey(const ValueKey("username"));
    await tester.enterText(username, "username");

    Finder location = find.byKey(const ValueKey("location"));
    await tester.enterText(location, "New kYork");

    Finder email = find.byKey(const ValueKey("email"));
    await tester.enterText(email, "Merrmnnmy2@gmail.com");

    Finder password = find.byKey(const ValueKey("password"));
    await tester.enterText(password, "Merrnnnny2@79789");
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

  // testWidgets("testing login ", (WidgetTester tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //     routes: {
  //       LoginScreen.id: (context) => LoginScreen(),
  //       NavigationDrawer.id: (context) => NavigationDrawer(
  //           idImage: ModalRoute.of(context)!.settings.arguments as Map),
  //     },
  //     home: LoginScreen(),
  //   ));

  //   Finder email = find.byKey(const ValueKey("email"));
  //   await tester.enterText(email, "cristiano@gmail.com");

  //   Finder password = find.byKey(const ValueKey("password"));
  //   await tester.enterText(password, "cristiano");
  //   Finder signin = find.byKey(const ValueKey("LogIn"));
  //   await tester.dragUntilVisible(
  //     signin,
  //     find.byType(Scaffold),
  //     const Offset(0, 70),
  //   );
  //   await tester.tap(signin);
  //   await tester.pumpAndSettle();
  //   expect(find.byType(ListView), findsWidgets);
  // });
}
