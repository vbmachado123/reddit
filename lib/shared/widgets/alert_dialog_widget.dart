import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final title;
  final Widget currentBody;

  const AlertDialogWidget({Key? key, this.title, required this.currentBody})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: currentBody,
      ),
    );
  }
}
