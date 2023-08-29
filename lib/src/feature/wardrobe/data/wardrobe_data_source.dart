import 'package:database/database.dart';
import 'package:drift/drift.dart';

part 'wardrobe_data_source.g.dart';

/// Abstract class that provides methods for interacting clothes
/// from a wardrobe data source.
abstract class WardrobeDataSource {
  /// Retrieves all clothes from the wardrobe data source.
  Future<List<Clothe>> getAllClothes();

  /// TODO: docs
  Future<void> insert(ClothesCompanion entry);
}

/// Accessing and interacting clothes from the database.
@DriftAccessor(tables: [AppDatabase])
class WardrobeDao extends DatabaseAccessor<AppDatabase>
    with _$WardrobeDaoMixin
    implements WardrobeDataSource {
  WardrobeDao(super.attachedDatabase);

  @override
  Future<List<Clothe>> getAllClothes() =>
      select(attachedDatabase.clothes).get();

  @override
  Future<void> insert(ClothesCompanion entry) =>
      into(attachedDatabase.clothes).insert(entry);
}
