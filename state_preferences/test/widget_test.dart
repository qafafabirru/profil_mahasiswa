import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:state_preferences/main.dart';
import 'package:state_preferences/providers/user_provider.dart';
import 'package:state_preferences/utils/security_validator.dart';

void main() {
  testWidgets('Home menampilkan sapaan tamu dan counter kunjungan',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Selamat datang, Tamu!'), findsOneWidget);
    expect(find.text('Aplikasi dibuka 1 kali'), findsOneWidget);
  });

  test('SecurityValidator mendeteksi karakter berbahaya', () {
    expect(SecurityValidator.containsDangerousChars('<script>'), isTrue);
    expect(SecurityValidator.containsDangerousChars('Budi'), isFalse);
    expect(SecurityValidator.validateName('Budi'), isNull);
  });
}
