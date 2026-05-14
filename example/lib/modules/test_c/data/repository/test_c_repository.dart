/// Defines contract for Auth data operations.
/// This abstraction allows swapping implementations (API, local DB, etc.)
abstract class TestCRepository {

  /// Example method (you can extend this later)
  Future<void> fetchData();
}