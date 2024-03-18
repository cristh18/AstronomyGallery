import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../base/datasource/data_source.dart';

class LocalDataStorege implements DataSource<String> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  @override
  Future<bool> add(String data) {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String id) {
    return _storage.delete(key: id).then((_) => true).catchError((_) => false);
  }

  @override
  Future<String> retryData(String id) {
    return _storage.read(key: id).then((String? value) => value ?? '');
  }

  @override
  Future<void> set(String id, String data) {
    return _storage.write(key: id, value: data);
  }
}
