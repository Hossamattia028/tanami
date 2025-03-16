import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:task_project/feature/auth/data/data_sources/auth_data_source.dart';
import 'package:task_project/feature/auth/data/repositories/auth_repository.dart';
import 'package:task_project/feature/auth/domain/repositories/auth_repository.dart';
import 'package:task_project/feature/auth/domain/usecases/auth_use_case.dart';
import 'package:task_project/feature/auth/presentation/blocs/auth_bloc.dart';
import 'package:task_project/feature/investment/data/data_sources/investment_remote_data_source.dart';
import 'package:task_project/feature/investment/data/repositories/investment_repository.dart';
import 'package:task_project/feature/investment/domain/repositories/investment_repository.dart';
import 'package:task_project/feature/investment/domain/usecases/get_investments.dart';
import 'package:task_project/feature/investment/presentation/blocs/investment_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  ///  initial
  sl.registerFactory(() => InvestmentBloc(
      sl(),
    ));

  sl.registerLazySingleton(() => GetInvestmentsUseCase(sl()));

  sl.registerLazySingleton<InvestmentRepository>(() => InvestmentModelRepository(investmentRemoteDataSource: sl(),));
   
  sl.registerLazySingleton<InvestmentRemoteDataSource>(() => InvestmentRemoteDataSource());



  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Data Sources
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSource(sl<FirebaseAuth>()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl<AuthDataSource>()));

  // Use Cases
  sl.registerLazySingleton(() => SignInUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignUpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignOutUseCase(sl<AuthRepository>()));

  // Bloc
  sl.registerFactory(() => AuthBloc(
        signInUseCase: sl<SignInUseCase>(),
        signUpUseCase: sl<SignUpUseCase>(),
        signOutUseCase: sl<SignOutUseCase>(),
      ));

}