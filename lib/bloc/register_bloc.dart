import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atma_kitchen_mobile/bloc/form_submission_state.dart';
import 'package:atma_kitchen_mobile/bloc/register_event.dart';
import 'package:atma_kitchen_mobile/bloc/register_state.dart';
import 'package:atma_kitchen_mobile/model/user.dart';
import 'package:atma_kitchen_mobile/repository/register_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository = RegisterRepository();
  RegisterBloc() : super(RegisterState()) {
    on<IsPasswordVisibleChanged>(
        (event, emit) => _onIsPasswordVisibleChanged(event, emit));
    on<FormSubmitted>((event, emit) => _onFormSubmitted(event, emit));
  }

  void _onIsPasswordVisibleChanged(
      IsPasswordVisibleChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
      formSubmissionState: const InitialFormState(),
    ));
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(formSubmissionState: FormSubmitting()));
    try {
      User userData = await registerRepository.register(event.username,
          event.password, event.noTlp, event.tanggalLahir, event.email);

      emit(state.copyWith(
          formSubmissionState: SubmissionSuccess(user: userData)));
    } on FailedRegister catch (e) {
      emit(state.copyWith(
          formSubmissionState: SubmissionFailed(e.errorMessage())));
    } on String catch (e) {
      emit(state.copyWith(formSubmissionState: SubmissionFailed(e)));
    } catch (e) {
      emit(state.copyWith(formSubmissionState: SubmissionFailed(e.toString())));
    }
  }
}
