import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:text_chunk_styling/text_chunk_styling.dart';

void main() {
  group('Arguments', () {
    group('assert', () {
      test('Cannot provide a negative maxLines', () {
        expect(
          () => TextChunkStyling(
            text: '',
            highlightText: [''],
            highlightTextStyle: TextStyle(),
            maxLines: -1,
          ),
          throwsAssertionError,
        );
      });

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

  group('Styling', () {
    testGoldens('display stylized text', (tester) async {
      await loadAppFonts();
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Container(
              child: TextChunkStyling(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus erat purus, sollicitudin et velit sed, suscipit euismod ipsum. Etiam ultricies purus a nunc condimentum, sollicitudin mollis tortor maximus. Phasellus fringilla augue a leo molestie feugiat. Donec eget nisi vel metus rhoncus ultricies. Donec non semper mi. Suspendisse dictum orci molestie libero vehicula, ut faucibus massa luctus. Etiam sit amet urna tristique, ullamcorper ex at, feugiat ipsum. Mauris ut leo quis magna tempus euismod. Nam euismod mauris quam, quis iaculis ligula ornare quis. Nunc egestas urna ac mauris consequat, id tincidunt justo iaculis. Ut posuere risus elit, vel facilisis nulla lobortis non.',
                highlightText: ['sum', 'ing', 'mod', 'ris', 'nam'],
                highlightTextStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
        ),
      );
      await screenMatchesGolden(tester, 'style_1');
    });

    testGoldens('display multi-stylized text', (tester) async {
      await loadAppFonts();
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Container(
              child: TextChunkStyling(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus erat purus, sollicitudin et velit sed, suscipit euismod ipsum. Etiam ultricies purus a nunc condimentum, sollicitudin mollis tortor maximus. Phasellus fringilla augue a leo molestie feugiat. Donec eget nisi vel metus rhoncus ultricies. Donec non semper mi. Suspendisse dictum orci molestie libero vehicula, ut faucibus massa luctus. Etiam sit amet urna tristique, ullamcorper ex at, feugiat ipsum. Mauris ut leo quis magna tempus euismod. Nam euismod mauris quam, quis iaculis ligula ornare quis. Nunc egestas urna ac mauris consequat, id tincidunt justo iaculis. Ut posuere risus elit, vel facilisis nulla lobortis non.',
                highlightText: ['sum', 'ing', 'mod', 'ris', 'nam'],
                multiTextStyles: [
                  TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                  TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                  TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                  TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                  TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await screenMatchesGolden(tester, 'style_2');
    });
  });
}
