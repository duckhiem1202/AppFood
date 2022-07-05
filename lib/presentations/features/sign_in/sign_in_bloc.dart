import 'dart:async';

import 'package:myappappsa/commons/bases/base_bloc.dart';
import 'package:myappappsa/commons/bases/base_event.dart';
import 'package:myappappsa/data/datasources/models/user_model.dart';
import 'package:myappappsa/data/repositories/authentication_repository.dart';
import 'package:myappappsa/presentations/features/sign_in/sign_in_event.dart';

class SignInBloc extends BaseBloc{
  StreamController<UserModel> userModelController = StreamController();
  StreamController<String> message = StreamController();
  late AuthenticationRepository _authenticationRepository;

  void setAuthenticationRepository({required AuthenticationRepository authenticationRepository}) {
    _authenticationRepository = authenticationRepository;
  }
  @override
  void dispatch(BaseEvent event) {
    if (event is LogninEvent) {
      _executeLogin(event);
    }
  }
  void _executeLogin(LogninEvent event) {
    loadingSink.add(true);
    _authenticationRepository
        .login(email: event.email, password: event.password)
        .then((userResponse) {
      userModelController.sink.add(UserModel(
          email: userResponse.email ?? "",
          name: userResponse.name ?? "",
          phone: userResponse.phone ?? "",
          token: userResponse.token ?? ""));
      loadingSink.add(false);
      progressSink.add(LoginSuccessEvent());
    }).catchError((error) {
      message.sink.add(error);
      loadingSink.add(false);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    userModelController.close();
    super.dispose();
  }

}