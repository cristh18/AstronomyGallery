abstract class DataSource<T> {
  Future<dynamic> set(String id, T data);

  Future<bool> add(T data);

  Future<List<T>> get();

  Future<bool> remove(String id);

  Future<T> retryData(String id);
}
