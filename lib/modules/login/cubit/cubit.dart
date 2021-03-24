import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter_app/modules/login/cubit/states.dart';
import 'package:sample_flutter_app/shared/network/repository.dart';

class LoginCubit extends Cubit<LoginStates> {
  final Repository _repository;

  LoginCubit(this._repository) : super(LoginStateInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  userLogin({
    @required String email,
    @required String password,
  }) async {
    emit(LoginStateLoading());

    final f = await _repository.userLogin(
      email: email,
      password: password,
    );

    f.fold(
      (l) async {
        emit(LoginStateError(l));
      },
      (r) async
      {
        emit(LoginStateSuccess(r.token));
      },
    );
  }
}
