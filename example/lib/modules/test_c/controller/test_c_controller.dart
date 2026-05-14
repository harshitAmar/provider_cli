import 'package:flutter/material.dart';

/// Controller for TestC module.
/// Handles business logic and state management using Provider.
class TestCController extends ChangeNotifier {

  /// Example state
  bool isLoading = false;

  /// Example method
  Future<void> loadData() async {
    isLoading = true;
    notifyListeners();

    // TODO: Call repository

    isLoading = false;
    notifyListeners();
  }
}