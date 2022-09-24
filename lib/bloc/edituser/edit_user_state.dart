part of 'edit_user_bloc.dart';

@immutable
abstract class EditUserState {}

class EditUserInitial extends EditUserState {}

class EditUserLoading extends EditUserState {}

class EditUserLoaded extends EditUserState {
  final EditResponse editResponse;
  EditUserLoaded({required this.editResponse});
}

class EditUserError extends EditUserState {}
