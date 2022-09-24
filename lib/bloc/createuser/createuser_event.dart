part of 'createuser_bloc.dart';

@immutable
abstract class CreateuserEvent {}

class CreateNewUser extends CreateuserEvent {
  final String username;
  final String job;
  CreateNewUser({required this.job, required this.username});
}
