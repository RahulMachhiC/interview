part of 'createuser_bloc.dart';

@immutable
abstract class CreateuserState {}

class CreateuserInitial extends CreateuserState {}

class CreateUserLoading extends CreateuserState {}

class CreateUserLoaded extends CreateuserState {
  final CreateuserRespone createuserRespone;
  CreateUserLoaded({required this.createuserRespone});
}

class CreateUserError extends CreateuserState {}
