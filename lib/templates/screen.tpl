import 'package:flutter/material.dart';

/// UI screen for {{name}} module.
class {{name}}Screen extends StatelessWidget {
  const {{name}}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{{name}}')),
      body: const Center(
        child: Text('{{name}} Screen'),
      ),
    );
  }
}