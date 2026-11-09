import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:state_preferences/main.dart';
import 'package:state_preferences/providers/user_provider.dart';

void main() {
  testWidgets('Home menampilkan sapaan tamu', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Selamat datang, Tamu!'), findsOneWidget);
  });
}
