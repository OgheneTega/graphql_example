import 'package:gaphql_example/services/graphql_service.dart';
import 'package:gaphql_example/viewmodels/auth_view_model.dart';
import 'package:gaphql_example/viewmodels/profile_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => AuthViewModel());
  locator.registerLazySingleton(() => ProfileViewModel());
  locator.registerLazySingleton(() => GraphQLService());
}
