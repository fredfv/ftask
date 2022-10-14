// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:task/src/core/services/object_id_service.dart';
//
// import '../../../core/application/create_account_request.dart';
// import '../../../core/application/custom_exception.dart';
// import '../../../core/application/login_request.dart';
// import '../../../core/application/mapping/user_mapper.dart';
// import '../../../core/domain/repositories/login_repository.dart';
// import '../../../core/domain/user_entity.dart';
// import '../../../core/infra/http_request_methods.dart';
// import '../../../core/infra/logger.dart';
// import '../../../core/services/http_service.dart';
// import '../../../core/services/local_storage/hive_repository.dart';
//
// //TODO - REFACTOR THIS CODE AND MAKE USE CASE AFTER ALL METHODS
// class LoginRepositoryImpl extends HiveReposiotry<UserEntity> implements LoginRepository {
//   final HttpService httpService;
//
//   LoginRepositoryImpl({
//     required this.httpService,
//     required ObjectIdService objectIdService,
//   }) : super(
//           mapper: UserMapper(),
//           objectId: objectIdService,
//         );
//
//   @override
//   Future login(LoginRequest loginRequest) async {
//     return httpService.request(
//         baseUrl: 'http://192.168.15.3:5001',
//         endPoint: '/Person/auth',
//         method: HttpRequestMethods.post,
//         params: loginRequest.toJson(),
//         receiveTimeout: 5000,
//         connectTimeout: 10000);
//   }
//
//
//   @override
//   Future createAccount(CreateAccountRequest newAccount) async {
//     return httpService.request(
//         baseUrl: 'http://192.168.15.3:5001',
//         endPoint: '/Person/createaccount',
//         method: HttpRequestMethods.post,
//         params: newAccount.toJson(),
//         receiveTimeout: 5000,
//         connectTimeout: 10000);
//   }
//
//   @override
//   Future persistAuthLogin(Map<String, dynamic> response) async {
//     UserEntity user = UserEntity.fromAuth(response);
//     user.setCreated(DateTime.now().toUtc());
//     await put(user.id, user);
//   }
//
//   @override
//   Future<bool> isAuthenticated(String? idLoggedUser) async {
//     if (idLoggedUser == null) {
//       var lastUser = await getLoggedUser();
//       idLoggedUser = lastUser.id;
//     }
//     var userToVerify = await get(idLoggedUser);
//     if (userToVerify == null) throw CustomException('user not found');
//     return JwtDecoder.isExpired(userToVerify.token);
//   }
//
//   @override
//   Future<UserEntity> getLoggedUser() async {
//     var allUsers = box.values.toList();
//     allUsers.sort((a, b) => a['created'].compareTo(b['created']));
//     fLog.wtf(allUsers.last.toString());
//     fLog.wtf(allUsers.first.toString());
//     return UserEntity.fromJson(allUsers.last);
//   }
// }
