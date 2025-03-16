import 'package:task_project/feature/auth/domain/entities/auth.dart';

abstract class AuthRepository {
  Future<UserEntity?> signInWithEmail(String email, String password);
  Future<UserEntity?> signUpWithEmail(String email, String password);
  Future<void> signOut();
  UserEntity? getCurrentUser();
}
