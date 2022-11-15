import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DrawerDashBoard extends StatefulWidget {
  const DrawerDashBoard({super.key});

  @override
  State<DrawerDashBoard> createState() => _DrawerDashBoardState();
}

class _DrawerDashBoardState extends State<DrawerDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [DrawerHeader(child: Text('Drawer'))],
      ),
    );
  }
}
