import 'package:task_project/feature/auth/domain/entities/auth.dart';
import 'package:task_project/feature/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  const SignInUseCase(this.repository);

  Future<UserEntity?> call(String email, String password) {
    return repository.signInWithEmail(email, password);
  }
}

// sign_out_usecase.dart
class SignOutUseCase {
  final AuthRepository repository;

  const SignOutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}

class SignUpUseCase {
  final AuthRepository repository;

  const SignUpUseCase(this.repository);

  Future<UserEntity?> call(String email, String password) {
    return repository.signUpWithEmail(email, password);
  }
}
