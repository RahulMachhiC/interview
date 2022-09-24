import 'package:bloc/bloc.dart';
import 'package:interview/models/EditResponse.dart';
import 'package:interview/repository/apiservice.dart';
import 'package:meta/meta.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  EditUserBloc() : super(EditUserInitial()) {
    on<EditUserEvent>((event, emit) async {
      if (event is DoEditUser) {
        emit.call(EditUserLoading());
        try {
          final EditResponse editResponse = await edituser(
              id: event.id, username: event.username, job: event.job);
          emit.call(EditUserLoaded(editResponse: editResponse));
        } catch (e) {
          print(e);
          emit.call(EditUserError());
        }
      }
    });
  }
}
