abstract class RegisterEvent {}

class IsPasswordVisibleChanged extends RegisterEvent {}

class FormSubmitted extends RegisterEvent {
  String username;
  String password;
  String noTlp;
  String tanggalLahir;
  String email;

  FormSubmitted(
      {required this.username,
      required this.password,
      required this.noTlp,
      required this.tanggalLahir,
      required this.email});
}
