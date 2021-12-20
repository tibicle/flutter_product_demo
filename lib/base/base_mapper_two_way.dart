import 'base_mapper.dart';

abstract class BaseMapperTwoWay<T, V> extends BaseMapper<T, V> {
  T reverseMap(V v);
}
