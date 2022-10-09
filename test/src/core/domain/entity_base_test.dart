import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task/src/core/domain/entity_base.dart';

class MockEntity extends Mock implements EntityBase {}

void main() {
  test('implements EntityBase', () {
    expect(MockEntity(), isA<EntityBase>());
  });

  //test if the method toJson is implemented
  test('implements toJson', () {
    final entity = MockEntity();
    when(() => entity.toJson()).thenReturn({});
    expect(entity.toJson(), isA<Map<String, dynamic>>());
  });

  //test a instance of a new MockEntity is created
  test('create a new instance', () {
    final entity = MockEntity();
    expect(entity, isA<MockEntity>());
  });
}