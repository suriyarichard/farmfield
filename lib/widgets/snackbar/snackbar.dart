import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: Color.fromRGBO(0, 0, 0, 65),
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {},
      ),
    ),
  );
}

void showSnackBars(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: const TextStyle(color: Colors.red),
      ),
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.745),
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {},
      ),
    ),
  );
}
