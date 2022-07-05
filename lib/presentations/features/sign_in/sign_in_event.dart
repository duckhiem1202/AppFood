import 'package:myappappsa/commons/bases/base_event.dart';

abstract class SignInEvent extends BaseEvent{

}

class LogninEvent extends SignInEvent{
  late String email, password;
  LogninEvent({required this.email, required this.password});

  @override
  List <Object> get props =>[];
}
class LoginSuccessEvent extends SignInEvent {

  LoginSuccessEvent();

  @override
  List<Object?> get props => [];

}