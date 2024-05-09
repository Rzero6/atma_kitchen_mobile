import 'package:atma_kitchen_mobile/bloc/form_submission_state.dart';

class RegisterState {
  final bool isPasswordVisible;
  final FormSubmissionState formSubmissionState;

  RegisterState({
    this.isPasswordVisible = true,
    this.formSubmissionState = const InitialFormState(),
  });

  RegisterState copyWith({
    bool? isPasswordVisible,
    FormSubmissionState? formSubmissionState,
  }) {
    return RegisterState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
    );
  }
}
