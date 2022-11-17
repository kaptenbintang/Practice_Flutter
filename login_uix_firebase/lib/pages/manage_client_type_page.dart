import 'package:flutter/material.dart';

class ManageClients extends StatefulWidget {
  static const routeName = '/manageClientTypePage';
  const ManageClients({super.key});

  @override
  State<ManageClients> createState() => _ManageClientsState();
}

class _ManageClientsState extends State<ManageClients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Client Type")),
    );
  }
}
