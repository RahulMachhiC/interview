part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class FethcUserEvent extends UserEvent {
  final int pageKey;
  FethcUserEvent({required this.pageKey});
}
