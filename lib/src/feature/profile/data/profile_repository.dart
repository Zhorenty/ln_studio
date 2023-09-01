import '../model/profile.dart';
import 'profile_data_source.dart';

abstract interface class ProfileRepository {
  /// Get the profile of the current user from the server.
  Future<Profile> getProfileFromServer();

  /// Get the profile of the current user from the cache.
  Profile? getProfileFromCache();
}

final class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required this.dataSource,
  });

  final ProfileDataSource dataSource;

  @override
  Future<Profile> getProfileFromServer() async =>
      dataSource.loadProfileFromServer();

  @override
  Profile? getProfileFromCache() => dataSource.loadProfileFromCache();
}
