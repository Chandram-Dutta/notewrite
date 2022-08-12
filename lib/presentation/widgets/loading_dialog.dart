import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showLoaderDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const CupertinoAlertDialog(
        title: Text("Loading"),
        content: CupertinoActivityIndicator(),
      );
    },
  );
}
