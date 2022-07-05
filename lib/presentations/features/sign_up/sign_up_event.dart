import 'package:myappappsa/commons/bases/base_event.dart';

abstract class SignUpEvent extends BaseEvent{}
class SignUpExecuteEvent extends SignUpEvent{
  late String email, password, name, phone, address;

  SignUpExecuteEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.address}
      );

  @override
  List <Object> get props =>[];
}
class SignUpSuccessEvent extends SignUpEvent{
  @override
  List <Object> get props =>[];
}