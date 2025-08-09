// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:streaming_app/main.dart';

void main() {
  testWidgets('Navigation et recherche fonctionnent', (WidgetTester tester) async {
    await tester.pumpWidget(const MonApplication());

    // Accueil visible
    expect(find.text('Vos émissions en streaming'), findsOneWidget);

    // Ouvrir l’onglet Recherche via la barre
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Champ de recherche présent
    expect(find.byType(TextField), findsOneWidget);

    // Taper une requête qui filtre (ex: "Parole")
    await tester.enterText(find.byType(TextField), 'Parole');
    await tester.pumpAndSettle();

    // Devrait rester affiché au moins un résultat
    expect(find.textContaining('Parole'), findsWidgets);
  });
}
