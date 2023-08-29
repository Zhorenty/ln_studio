import 'package:drift/drift.dart';

/// QueryExecutor for unsupported platform.
///
/// Throws an [UnsupportedError].
QueryExecutor openConnection(String name) => throw UnsupportedError(
      'Platform is not recognised as supported one',
    );
