import 'package:bloc/bloc.dart';
import 'package:interview/models/CreatrUserResponse.dart';
import 'package:interview/repository/apiservice.dart';
import 'package:meta/meta.dart';

part 'createuser_event.dart';
part 'createuser_state.dart';

class CreateuserBloc extends Bloc<CreateuserEvent, CreateuserState> {
  CreateuserBloc() : super(CreateuserInitial()) {
    on<CreateuserEvent>((event, emit) async {
      if (event is CreateNewUser) {
        emit.call(CreateUserLoading());
        try {
          final CreateuserRespone createuserRespone =
              await createuser(username: event.username, job: event.job);
          emit.call(CreateUserLoaded(createuserRespone: createuserRespone));
        } catch (e) {
          print(e);
          emit.call(CreateUserError());
        }
      }
    });
  }
}
