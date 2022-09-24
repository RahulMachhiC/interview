part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserResponse userResponse;
  UserLoaded({required this.userResponse});
}

class UserError extends UserState {}
