import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/data_model.dart';
import 'package:flutter_assignment/presentation/widgets/article_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test articleCard widget', (WidgetTester tester) async {
    final mockDataModel = DataModel(
      title: 'Title#',
      body: 'some random desc',
      url: 'https://www.google.com/',
      creationTime: DateTime.now(),
      after: '',
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ArticleCard(dataModel: mockDataModel),
        ),
      ),
    );

    expect(find.text('Title#'), findsOneWidget);
    expect(find.text('some random desc'), findsOneWidget);
    await tester.tap(find.text('Title#'));
    await tester.pump();
  });
}
