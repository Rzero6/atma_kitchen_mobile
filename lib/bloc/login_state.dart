import 'package:atma_kitchen_mobile/bloc/form_submission_state.dart';

class LoginState {
  final bool isPasswordVisible;
  final FormSubmissionState formSubmissionState;

  LoginState({
    this.isPasswordVisible = true,
    this.formSubmissionState = const InitialFormState(),
  });

  LoginState copyWith({
    bool? isPasswordVisible,
    FormSubmissionState? formSubmissionState,
  }) {
    return LoginState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
    );
  }
}
