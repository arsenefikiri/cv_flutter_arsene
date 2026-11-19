import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cv_flutter_arsene/main.dart';

void main() {
  testWidgets('Affichage et connexion sur le CV Flutter d\'Arsène', (
    WidgetTester tester,
  ) async {
    
    await tester.pumpWidget(const MonCvApp());

    
    expect(find.text('Connexion'), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));

   
    await tester.enterText(
      find.byType(TextFormField).first,
      'arsenefikiri04@gmail.com',
    );
    await tester.enterText(find.byType(TextFormField).last, '123456');

    
    final visibilityIcon = find.byIcon(Icons.visibility_off);
    if (visibilityIcon.evaluate().isNotEmpty) {
      await tester.tap(visibilityIcon.first);
      await tester.pump();
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    }

    
    await tester.tap(find.text('Se connecter'));
    await tester.pumpAndSettle();

    
    expect(find.text('IRAGI FIKIRI ARSENE'), findsOneWidget);
    expect(find.text('PROFIL'), findsOneWidget);
  });
}
