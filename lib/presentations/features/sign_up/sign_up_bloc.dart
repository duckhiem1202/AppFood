
import 'dart:async';

import 'package:myappappsa/commons/bases/base_bloc.dart';
import 'package:myappappsa/commons/bases/base_event.dart';
import 'package:myappappsa/data/datasources/models/user_model.dart';
import 'package:myappappsa/data/repositories/authentication_repository.dart';
import 'package:myappappsa/presentations/features/sign_up/sign_up_event.dart';

class SignUpBloc extends BaseBloc{
  StreamController <UserModel> usercontroller = StreamController();
  StreamController<String> message = StreamController();
  late AuthenticationRepository _authenticationRepository;

  void setAuthenticationRepository({required AuthenticationRepository authenticationRepository}) {
    _authenticationRepository = authenticationRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    if (event is SignUpExecuteEvent) {
      _executeSignUp(event);
    }
  }
  @override
  void dispose() {
    usercontroller.close();
    message.close();
    // TODO: implement dispose
    super.dispose();
  }

  void _executeSignUp(SignUpExecuteEvent event) {
    loadingSink.add(true);
    _authenticationRepository
        .register(email: event.email, password: event.password,
        name: event.name, phone: event.phone,address: event.address,

    )
        .then((userResponse) {
      usercontroller.sink.add(UserModel(
          email: userResponse.email ?? "",
          name: userResponse.name ?? "",
          phone: userResponse.phone ?? "",
          token: userResponse.token ?? ""));
      loadingSink.add(false);
      progressSink.add(SignUpExecuteEvent(email: "", password: "", name: "", phone: "", address: ""));
    }).catchError((error) {
      message.sink.add(error);
      loadingSink.add(false);
    });

  }
}
