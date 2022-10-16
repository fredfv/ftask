import 'package:task/src/core/domain/entities/task_entity.dart';

abstract class ISetOnBoardStatusUsecase {
  Future<bool> call(String id, bool onBoard);
}
