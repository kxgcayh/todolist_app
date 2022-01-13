import 'package:checklist_app/data/models/login_model.dart';
import 'package:checklist_app/data/models/register_model.dart';
import 'package:checklist_app/data/providers/api_provider.dart';
import 'package:checklist_app/data/repositories/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = Provider.autoDispose((ref) {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  ref.maintainState = true;
  return AuthenticationProvider(ref, cancelToken: cancelToken);
});

class AuthenticationProvider extends ApiProvider {
  AuthenticationProvider(Ref ref, {this.cancelToken}) : super(ref);
  final CancelToken? cancelToken;

  Future<RegistrationModel> register({
    required String username,
    required String email,
    required String password,
  }) async {
    RegistrationModel registrationModel;
    response = await postConnect(
      '/register',
      data: {
        "username": username,
        "email": email,
        "password": password,
      },
      cancel: cancelToken,
    );
    registrationModel = RegistrationModel.fromJson(response.data);
    return registrationModel;
  }

  Future<LoginModel> login({
    required String username,
    required String password,
  }) async {
    LoginModel loginModel;
    response = await postConnect(
      '/login',
      data: {
        "username": username,
        "password": password,
      },
      cancel: cancelToken,
    );
    loginModel = LoginModel.fromJson(response.data);
    return loginModel;
  }
}
