import 'package:flutter/material.dart';

class DialogManager {
  late ValueNotifier<Widget> _currentWidget;
  BuildContext? dialogContext;

  buildDialog(BuildContext context, Widget child){
    _currentWidget = ValueNotifier<Widget>(child);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: ValueListenableBuilder<Widget>(
              builder:(context, value, child) {
                return value;
              },
              valueListenable: _currentWidget,
            ),
          ),
        );
      },
    );
  }

  changeDialog(Widget widget){
    _currentWidget.value = widget;
  }

  dismissDialog() {
    if (dialogContext?.mounted ?? false) Navigator.pop(dialogContext!);
  }
}
