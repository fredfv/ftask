// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:task/src/core/domain/task_entity.dart';
// import 'package:task/src/core/domain/user_entity.dart';
// import 'package:task/src/core/services/http_service.dart';
//
// import '../../../core/domain/repositories/repository.dart';
// import '../../../core/domain/repositories/repository_factory.dart';
// import '../../../core/infra/http_request_methods.dart';
//
//
// class TaskRepositoryImpl extends HiveReposiotry<TaskEntity> implements TaskRepository {
//   final HttpService httpService;
//   TaskRepositoryImpl({
//     required this.httpService,
//     required ObjectIdService objectIdService,
//   }) : super(
//           mapper: TaskMapper(),
//           objectId: objectIdService,
//         );
//
//   @override
//   Future<List<TaskEntity>> getTasks() async {
//     var loggedUser = await Modular.get<LoginRepositoryImpl>().getLoggedUser();
//
//     var list = await httpService.request(
//         baseUrl: 'http://192.168.15.3:5001',
//         endPoint: '/task/getall',
//         method: HttpRequestMethods.get,
//         token: loggedUser.token,
//         receiveTimeout: 5000,
//         connectTimeout: 10000);
//
//     //obrigado a converter par um list de entidades
//
//     await putMany(list);
//
//     return await getAll();
//   }
//
//   @override
//   Future putTask(TaskEntity task) {
//     // TODO: implement putTask
//     throw UnimplementedError();
//   }
// }
