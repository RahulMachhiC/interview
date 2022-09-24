part of 'edit_user_bloc.dart';

@immutable
abstract class EditUserEvent {}

class DoEditUser extends EditUserEvent {
  final String id;
  final String username;
  final String job;
  DoEditUser({required this.id, required this.job, required this.username});
}
