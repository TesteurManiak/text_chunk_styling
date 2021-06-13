import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_chunk_styling/text_chunk_styling.dart';

void main() {
  group('Arguments', () {
    group('assert', () {
      test('Cannot provide both highlightTextStyle and multiTextStyles', () {
        expect(
          () => TextChunkStyling(
            text: '',
            highlightText: [''],
            highlightTextStyle: TextStyle(),
            multiTextStyles: [TextStyle()],
          ),
          throwsAssertionError,
        );
      });

      test('multiTextStyles must be the same length as highlightText', () {
        expect(
          () => TextChunkStyling(
            text: '',
            highlightText: [''],
            multiTextStyles: [TextStyle(), TextStyle()],
          ),
          throwsAssertionError,
        );
      });
    });
  });
}
