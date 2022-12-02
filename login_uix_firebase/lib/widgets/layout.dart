import 'package:flutter/material.dart';

class LayoutPage extends StatefulWidget {
  final String title;

  const LayoutPage({super.key, required this.title});

  @override
  State<LayoutPage> createState() => _LayoutState();
}

class _LayoutState extends State<LayoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USING LAYOUTBUILDER'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Colors.indigo.shade900,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                          'This is my max height: ${constraints.maxHeight}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                          'This is my max width: ${constraints.maxWidth.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              );
            }),
          ),
          Expanded(
            flex: 4,
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('This is my max height: ${constraints.maxHeight}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    Text('This is my max width: ${constraints.maxWidth}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
