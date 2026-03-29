part of 'get_provider_details_cubit.dart';

@immutable
sealed class GetProviderDetailsState {}

final class GetProviderDetailsInitial extends GetProviderDetailsState {}

final class GetProviderDetailsLoading extends GetProviderDetailsState {}

final class GetProviderDetailsLoaded extends GetProviderDetailsState {
  final UserInformation userInformation;
  GetProviderDetailsLoaded({required this.userInformation});
}

final class GetProviderDetailsError extends GetProviderDetailsState {
  final String message;
  GetProviderDetailsError({required this.message});
}
