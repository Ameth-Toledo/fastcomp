import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../core/network/api_client.dart';
import '../data/datasource/remote/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/register_usecase.dart';
import '../presentation/providers/login_provider.dart';
import '../presentation/providers/register_provider.dart';

class AuthDI {
  static Widget inject({required ApiClient apiClient, required Widget child}) {
    final repository = AuthRepositoryImpl(
      remoteDataSource: AuthRemoteDatasource(apiClient: apiClient),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(
            loginUseCase: LoginUseCase(repository: repository),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(
            registerUseCase: RegisterUseCase(repository: repository),
          ),
        ),
      ],
      child: child,
    );
  }
}
