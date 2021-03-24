abstract class BlogStates {}

class BlogStateInitial extends BlogStates {}

class BlogStateLoading extends BlogStates {}

class BlogStateSuccess extends BlogStates {}

class BlogStateError extends BlogStates {
  final String error;

  BlogStateError(this.error);
}