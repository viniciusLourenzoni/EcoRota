import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eco_rota/main.dart';

void main() {
  testWidgets('App inicia com AppBar e abas', (WidgetTester tester) async {
    // Carrega o app
    await tester.pumpWidget(const MyApp());

    // Verifica se o título aparece
    expect(
      find.text('EcoRota – Controle de Abastecimentos'),
      findsOneWidget,
    );

    // Verifica se a aba Dashboard está presente
    expect(find.byIcon(Icons.dashboard), findsOneWidget);

    // Verifica se a aba Abastecimentos está presente
    expect(find.byIcon(Icons.local_gas_station), findsOneWidget);

    // Verifica se a aba Postos está presente
    expect(find.byIcon(Icons.map), findsOneWidget);
  });
}
