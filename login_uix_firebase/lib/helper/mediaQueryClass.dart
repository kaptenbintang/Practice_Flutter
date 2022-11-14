import 'package:flutter/material.dart';

class mediaQueryClass extends StatefulWidget {
  final String title;

  const mediaQueryClass({super.key, required this.title});

  @override
  State<mediaQueryClass> createState() => _mediaQueryState();
}

class _mediaQueryState extends State<mediaQueryClass> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //getting the size property
    final orientation =
        MediaQuery.of(context).orientation; //getting the orientation
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Size of the screen: ${size.width}x${size.height}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Orientation of the screen: $orientation',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
