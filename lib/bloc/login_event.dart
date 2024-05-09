abstract class LoginEvent {}

class IsPasswordVisibleChanged extends LoginEvent {}

class FormSubmitted extends LoginEvent {
  String email;
  String password;

  FormSubmitted({required this.email, required this.password});
}