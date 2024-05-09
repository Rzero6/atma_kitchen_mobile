import 'package:atma_kitchen_mobile/model/user.dart';

abstract class FormSubmissionState {
  const FormSubmissionState();
}

class InitialFormState extends FormSubmissionState {
  const InitialFormState();
}

class FormSubmitting extends FormSubmissionState {}

class SubmissionSuccess extends FormSubmissionState {
  final User user;

  SubmissionSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class SubmissionFailed extends FormSubmissionState {
  final String exception;
  const SubmissionFailed(this.exception);
}
