abstract class BaseRepo<T, U> {
  Future<U> index(int page, [T? filter]);
  Future<U> show(int id);
  Future<U> store(Map data);
  Future<U> update(int id, Map data);
  Future<U> delete(int id);
}
