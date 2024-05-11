import '../../core/config/injector.dart';
import '../network/api_service.dart';

abstract class BaseRepository {
  const BaseRepository(this.path);

  final String path;

  ApiService get apiService => getIt.get<ApiService>();
}
