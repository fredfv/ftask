import 'package:task/src/core/domain/entities/entity_base.dart';
import 'package:task/src/core/domain/repositories/repository_factory.dart';

import '../../application/mapping/entity_mapper_factory.dart';
import '../../domain/repositories/repository.dart';
import '../object_id_service.dart';
import 'hive_repository.dart';

class HiveRepositoryFactory extends RepositoryFactory {
  final ObjectIdService objectId;
  final String path;

  HiveRepositoryFactory({required this.objectId, required this.path});

  ///create a instance of repository and init it
  @override
  Future<Repository<T>> get<T extends EntityBase>() async {
    EntityMapperFactory mapperFactory = EntityMapperFactory();
    HiveReposiotry<T> repository = HiveReposiotry<T>(
      mapper: mapperFactory.get<T>(),
      objectId: objectId,
    );
    await repository.init(path);
    return repository;
  }
}
