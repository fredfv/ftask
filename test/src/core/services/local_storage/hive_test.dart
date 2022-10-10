import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task/src/core/application/mapping/mapper.dart';
import 'package:task/src/core/domain/entity_base.dart';
import 'package:task/src/core/domain/repositories/repository.dart';
import 'package:task/src/core/services/local_storage/hive.dart';
import 'package:task/src/core/services/object_id_service.dart';

class MockObjectId extends Mock implements ObjectIdService {}

class MockEntity extends EntityBase {
  MockEntity({required super.id, required super.created});

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class MockMapper extends Mapper<MockEntity> {
  @override
  MockEntity? fromJson(map) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson(MockEntity value) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class MockRepository<T extends EntityBase> extends Mock implements Repository<T> {
  String get box => T.toString();

  @override
  Future init(String path) async {}
}

void main() {
  test('should create a MockRepository passing MockEntity', () {
    final repository = MockRepository<MockEntity>();
    expect(repository, isA<MockRepository<MockEntity>>());
  });

  test('should call init and getter box return MockEntity name', () async {
    final repository = MockRepository<MockEntity>();
    await repository.init('path');
    expect(repository.box == 'MockEntity', repository.box == 'MockEntity');
  });
}
