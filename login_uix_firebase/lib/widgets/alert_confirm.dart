import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/helper/database_service.dart';

class AlertDialogConfirm extends StatefulWidget {
  final String type;
  final String id;
  final BuildContext contexts;

  const AlertDialogConfirm(
      {super.key,
      required this.type,
      required this.id,
      required this.contexts});

  @override
  State<AlertDialogConfirm> createState() => _AlertDialogConfirmState();
}

class _AlertDialogConfirmState extends State<AlertDialogConfirm> {
  DataService service = DataService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Text('Are you sure want to delete this account?'),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        if (widget.type == 'Remove')
          TextButton(
            style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge),
            onPressed: () {
              service.markdeleteUser(widget.contexts, widget.id);

              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        if (widget.type == 'Restore')
          TextButton(
            style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Restore'),
          ),
      ],
    );
  }
}
