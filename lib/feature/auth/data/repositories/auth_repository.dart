import 'package:task_project/feature/auth/data/data_sources/auth_data_source.dart';
import 'package:task_project/feature/auth/domain/entities/auth.dart';
import 'package:task_project/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  const AuthRepositoryImpl(this._authDataSource);

  @override
  Future<UserEntity?> signInWithEmail(String email, String password) async {
    final user = await _authDataSource.signInWithEmail(email, password);
    return user != null ? UserEntity(uid: user.uid, email: user.email!) : null;
  }

  @override
  Future<UserEntity?> signUpWithEmail(String email, String password) async {
    final user = await _authDataSource.signUpWithEmail(email, password);
    return user != null ? UserEntity(uid: user.uid, email: user.email!) : null;
  }

  @override
  Future<void> signOut() async {
    await _authDataSource.signOut();
  }

  @override
  UserEntity? getCurrentUser() {
    final user = _authDataSource.getCurrentUser();
    return user != null ? UserEntity(uid: user.uid, email: user.email!) : null;
  }
}
