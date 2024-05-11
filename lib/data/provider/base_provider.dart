import '../../core/config/injector.dart';
import '../database/local_storage.dart';
import '../repository/base_repository.dart';

abstract class BaseProvider<T extends BaseRepository> {
  const BaseProvider();

  T get repository => getIt.get<T>();

  LocalStorage get storage => getIt.get<LocalStorage>();
}
