import 'package:drift/drift.dart';
import 'package:drift/web.dart';

/// Web version of [QueryExecutor].
QueryExecutor openConnection(String name) => WebDatabase(name);
