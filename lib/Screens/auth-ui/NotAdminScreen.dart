import 'package:flutter/material.dart';

class NotAdminScreen extends StatelessWidget {
  const NotAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
            "Email not recognized as admin please ask admin to provide you admin privileges"),
      ),
    );
  }
}
