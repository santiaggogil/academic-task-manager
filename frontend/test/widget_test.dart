import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:frontend/main.dart';
import 'package:frontend/providers/auth_provider.dart';

void main() {
  testWidgets('App renders correctly smoke test', (WidgetTester tester) async {
    // Proporcionamos el AuthProvider que MyApp necesita
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    );

    // Verificamos que se renderice el widget principal
    expect(find.byType(MyApp), findsOneWidget);
  });
}
