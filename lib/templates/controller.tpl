import 'package:flutter/material.dart';

/// Controller for {{name}} module.
/// Handles business logic and state management using Provider.
class {{name}}Controller extends ChangeNotifier {

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