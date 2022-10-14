import 'package:task/src/core/domain/entity_base.dart';

import 'repository.dart';

abstract class RepositoryFactory {
  Future<Repository<T>> get<T extends EntityBase>();
}
