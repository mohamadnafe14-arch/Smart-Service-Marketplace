abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {}

class ServicesError extends ServicesState {
  final String message;
  ServicesError(this.message);
}