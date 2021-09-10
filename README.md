# text_chunk_styling

[![Pub Version](https://img.shields.io/pub/v/text_chunk_styling)](https://pub.dev/packages/text_chunk_styling)
[![Issues](https://img.shields.io/github/issues/TesteurManiak/text_chunk_styling)](https://github.com/TesteurManiak/text_chunk_styling/issues)
[![License](https://img.shields.io/github/license/TesteurManiak/text_chunk_styling)](https://github.com/TesteurManiak/text_chunk_styling/blob/main/LICENSE)

Flutter package which allows to style specific parts of a String.

## Getting Started

Add `text_chunk_styling` to your `pubspec.yaml` :

``` yaml
    text_chunk_styling: any
```

## Code Sample

### Flutter Code

``` dart
TextChunkStyling(
    text:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus erat purus, sollicitudin et velit sed, suscipit euismod ipsum. Etiam ultricies purus a nunc condimentum, sollicitudin mollis tortor maximus. Phasellus fringilla augue a leo molestie feugiat. Donec eget nisi vel metus rhoncus ultricies. Donec non semper mi. Suspendisse dictum orci molestie libero vehicula, ut faucibus massa luctus. Etiam sit amet urna tristique, ullamcorper ex at, feugiat ipsum. Mauris ut leo quis magna tempus euismod. Nam euismod mauris quam, quis iaculis ligula ornare quis. Nunc egestas urna ac mauris consequat, id tincidunt justo iaculis. Ut posuere risus elit, vel facilisis nulla lobortis non.',
    highlightText: ['sum', 'ing', 'mod', 'ris', 'nam'],
    multiTextStyles: [
        TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
    ],
);
```

### Result

![Screenshot](https://raw.githubusercontent.com/TesteurManiak/text_chunk_styling/main/test/goldens/style_2.png)

Find the full example in `example/`
