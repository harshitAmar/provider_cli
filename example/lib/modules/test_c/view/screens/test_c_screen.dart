import 'package:flutter/material.dart';

/// UI screen for TestC module.
class TestCScreen extends StatelessWidget {
  const TestCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TestC')),
      body: const Center(
        child: Text('TestC Screen'),
      ),
    );
  }
}