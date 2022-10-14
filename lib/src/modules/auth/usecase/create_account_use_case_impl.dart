import 'package:task/src/core/application/create_account_request.dart';
import 'package:task/src/core/infra/logger.dart';

import '../../../core/domain/repositories/repository_factory.dart';
import '../../../core/domain/services/http_service.dart';
import '../../../core/domain/usecases/create_account_usecase.dart';
import '../../../core/infra/http_request_methods.dart';

class CreateAccountUsecaseImpl implements CreateAccountUsecase {
  final HttpService httpService;
  final RepositoryFactory repositoryFactory;

  CreateAccountUsecaseImpl({required this.httpService, required this.repositoryFactory});

  @override
  Future<bool> call(CreateAccountRequest request) async {
    try {
      await httpService.request(
          baseUrl: 'http://192.168.15.3:5001',
          endPoint: '/Person/createaccount',
          method: HttpRequestMethods.post,
          params: request.toJson(),
          receiveTimeout: 5000,
          connectTimeout: 10000);

      return true;
    } catch (e) {
      fLog.e(e);
      return false;
    }
  }
}
