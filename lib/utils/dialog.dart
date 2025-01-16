import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
  }) {
    return showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: title,
      ),
    );
  }

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Text(title),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
