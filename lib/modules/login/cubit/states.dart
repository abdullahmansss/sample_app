abstract class LoginStates {}

class LoginStateInitial extends LoginStates {}

class LoginStateLoading extends LoginStates {}

class LoginStateSuccess extends LoginStates
{
  final String token;

  LoginStateSuccess(this.token);
}

class LoginStateError extends LoginStates {
  final String error;

  LoginStateError(this.error);
}