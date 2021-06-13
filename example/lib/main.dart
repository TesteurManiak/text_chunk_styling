import 'package:flutter/material.dart';
import 'package:text_chunk_styling/text_chunk_styling.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: TextChunkStyling(
            text:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus erat purus, sollicitudin et velit sed, suscipit euismod ipsum. Etiam ultricies purus a nunc condimentum, sollicitudin mollis tortor maximus. Phasellus fringilla augue a leo molestie feugiat. Donec eget nisi vel metus rhoncus ultricies. Donec non semper mi. Suspendisse dictum orci molestie libero vehicula, ut faucibus massa luctus. Etiam sit amet urna tristique, ullamcorper ex at, feugiat ipsum. Mauris ut leo quis magna tempus euismod. Nam euismod mauris quam, quis iaculis ligula ornare quis. Nunc egestas urna ac mauris consequat, id tincidunt justo iaculis. Ut posuere risus elit, vel facilisis nulla lobortis non.',
            highlightText: ['sum', 'ing', 'mod', 'ris', 'nam'],
            highlightTextStyle:
                TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            multiTextStyles: [
              TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
              TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
            ],
          ),
        ),
      ),
    );
  }
}
