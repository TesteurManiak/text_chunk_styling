import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:text_chunk_styling/text_chunk_styling.dart';

void main() {
  group('stackoverflow', () {
    testGoldens('stackoverflow_1', (tester) async {
      await loadAppFonts();
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: SizedBox(
              child: TextChunkStyling(
                text: 'trending items',
                highlightText: const ['trending'],
                highlightTextStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
      await screenMatchesGolden(tester, 'stackoverflow_1');
    });

    testGoldens('stackoverflow_2', (tester) async {
      await loadAppFonts();
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: SizedBox(
              child: TextChunkStyling(
                text: 'trending items',
                highlightText: const ['trending items'],
                highlightTextStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
      await screenMatchesGolden(tester, 'stackoverflow_2');
    });
  });
}
