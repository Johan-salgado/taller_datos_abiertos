import 'package:flutter_test/flutter_test.dart';
import 'package:taller_datos_abiertos/main.dart';

void main() {
  testWidgets('Smoke test inicial de la aplicación', (WidgetTester tester) async {
    // Renderizamos la aplicación
    await tester.pumpWidget(const MyApp());

    // Verificamos que se renderice el título del dashboard
    expect(find.text('Colombia Open Data'), findsOneWidget);
    expect(find.text('Departamentos'), findsOneWidget);
    expect(find.text('Presidentes'), findsOneWidget);
  });
}
