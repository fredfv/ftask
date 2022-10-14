import '../../../core/domain/services/http_service.dart';
import '../../../core/domain/usecases/create_account_usecase.dart';
import '../../../core/infra/application/create_account_request.dart';
import '../../../core/infra/application/http_request_methods.dart';
import '../../../core/infra/application/logger.dart';

class CreateAccountUsecaseImpl implements CreateAccountUsecase {
  final HttpService httpService;

  CreateAccountUsecaseImpl({required this.httpService});

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
