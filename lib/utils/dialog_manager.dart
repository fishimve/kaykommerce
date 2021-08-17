import 'package:flutter/material.dart';
import 'package:kaykommerce/models/dialog_models.dart';
import 'package:kaykommerce/ui/widgets/kayko_text.dart';

import '../locator.dart';
import '../services/dialog_service.dart';

class DialogManager extends StatefulWidget {
  final Widget? child;
  DialogManager({Key? key, required this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  var _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: KaykoText.subheading(request.title),
        content: KaykoText.body(request.description),
        actions: <Widget>[
          if (isConfirmationDialog)
            TextButton(
              child: KaykoText.body(request.cancelTitle!),
              onPressed: () {
                _dialogService.dialogComplete(
                  DialogResponse(confirmed: false),
                );
              },
            ),
          TextButton(
            child: KaykoText.body(request.buttonTitle),
            onPressed: () {
              _dialogService.dialogComplete(
                DialogResponse(confirmed: true),
              );
            },
          ),
        ],
      ),
    );
  }
}
