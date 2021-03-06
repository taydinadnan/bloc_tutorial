import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginuibloc/auth/sign_up/sign_up_event.dart';
import 'package:loginuibloc/auth/sign_up/sign_up_state.dart';

import '../form_submission_status.dart';
import '../auth_repository.dart';
import '../confirm/auth_cubit.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository? authRepo;
  final AuthCubit? authCubit;

  SignUpBloc({this.authRepo, this.authCubit}) : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    // Username updated
    if (event is SignUpUsernameChanged) {
      yield state.copyWith(username: event.username);

      // Email updated
    } else if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);

      // Password updated
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.signUp(
          username: state.username,
          email: state.email,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit!.showConfirmSignUp(
          username: state.username,
          email: state.email,
          password: state.password,
        );
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
