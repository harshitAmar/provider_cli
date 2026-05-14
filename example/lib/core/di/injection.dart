import 'package:get_it/get_it.dart';

import '../../modules/test_c/data/repository/test_c_repository.dart';
import '../../modules/test_c/data/implementation/test_c_repository_impl.dart';
// @provider_cli-di-import

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton<TestCRepository>(() => TestCRepositoryImpl());
// @provider_cli-di-insert
}
