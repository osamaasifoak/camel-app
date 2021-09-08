import '../base_localdb_service.dart';

// ignore_for_file: avoid_unused_constructor_parameters
// ignore_for_file: avoid_private_typedef_functions
typedef _SQLQueryResult = List<Map<String, Object?>>;

/// this class is fake implementation of [BaseLocalDbService] so
/// that the app can still normally on the web
///
/// while at the same time, the app actually "silently fails"
class LocalDbService implements BaseLocalDbService {
  const LocalDbService({
    List<String>? createTablesQueries,
    List<String>? tablesNames,
  });

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #select) {
      return Future<_SQLQueryResult>.value(const <Map<String, Object?>>[]);
    }
    if (invocation.memberName == #closeDb ||
        invocation.memberName == #clearDb) {
      return _dummyFutureVoid();
    }
  }

  Future<void> _dummyFutureVoid() async {
    // no-op
  }
}
