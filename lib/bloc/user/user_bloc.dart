import 'package:bloc/bloc.dart';
import 'package:interview/models/userresponse.dart';
import 'package:interview/repository/apiservice.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is FethcUserEvent) {
        emit.call(UserLoading());
        try {
          final UserResponse userResponse = await fetchusers(event.pageKey);
          emit.call(UserLoaded(userResponse: userResponse));
        } catch (e) {
          emit.call(UserError());
        }
      }
    });
  }
}
