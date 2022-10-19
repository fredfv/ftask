import 'package:task/src/core/infra/application/http_timeout_configurations.dart';

import '../../../core/domain/services/i_http_service.dart';
import '../../../core/domain/usecases/i_create_account_usecase.dart';
import '../../../core/infra/application/api_path.dart';
import '../../../core/infra/application/create_account_request.dart';
import '../../../core/infra/application/api_endpoints.dart';
import '../../../core/infra/application/http_request_methods.dart';
import '../../../core/infra/application/logger.dart';

class CreateAccountUsecase implements ICreateAccountUsecase {
  final IHttpService httpService;

  CreateAccountUsecase({required this.httpService});

  @override
  Future<bool> call(CreateAccountRequest request) async {
    try {
      await httpService.request(
          baseUrl: ApiPath.baseUrl,
          endPoint: ApiEndpoints.createAccount,
          method: HttpRequestMethods.post,
          params: request.toJson(),
          receiveTimeout: HttpTimeoutConfigurations.receiveTimeoutUsecases,
          connectTimeout: HttpTimeoutConfigurations.connectTimeoutUsecases);

      return true;
    } catch (e) {
      fLog.e(e);
      return false;
    }
  }
}
