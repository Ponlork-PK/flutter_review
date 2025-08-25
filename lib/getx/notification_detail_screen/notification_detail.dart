import 'package:flutter/material.dart';

class NotificationDetail extends StatelessWidget {

  final String? title;
  final String? body;
  const NotificationDetail({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: Center(child: Text(body!)),
    );
  }
}