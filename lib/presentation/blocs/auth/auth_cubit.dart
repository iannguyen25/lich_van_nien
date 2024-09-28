import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/user_repository.dart';

// Các trạng thái của AuthCubit
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final User user;
  AuthLoaded(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// AuthCubit
class AuthCubit extends Cubit<AuthState> {
  final UserRepository userRepository;

  AuthCubit({required this.userRepository}) : super(AuthInitial());

  // Lưu thông tin người dùng
  Future<void> saveUser(User user) async {
    emit(AuthLoading());
    try {
      await userRepository.saveUser(user);
      emit(AuthLoaded(user));
    } catch (e) {
      emit(AuthError('Failed to save user: ${e.toString()}'));
    }
  }

  // Lấy thông tin người dùng
  Future<void> getUser() async {
    emit(AuthLoading());
    try {
      User? user = await userRepository.getUser();
      if (user != null) {
        emit(AuthLoaded(user));
      } else {
        emit(AuthError('No user found'));
      }
    } catch (e) {
      emit(AuthError('Failed to load user: ${e.toString()}'));
    }
  }

  // Xóa thông tin người dùng
  Future<void> deleteUser() async {
    emit(AuthLoading());
    try {
      await userRepository.deleteUser();
      emit(AuthInitial()); // Reset state after deleting
    } catch (e) {
      emit(AuthError('Failed to delete user: ${e.toString()}'));
    }
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      User? user = await userRepository.getUser();
      if (user != null) {
        emit(AuthLoaded(user));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthError('Failed to check auth status: ${e.toString()}'));
    }
  }
}
