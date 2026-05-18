part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<Chat> chats;
  final List<PaginationLink> pagination;
  ChatLoaded({required this.chats, required this.pagination});
}
final class ChatError extends ChatState {
  final String message;
  ChatError({required this.message});
}
final class ChatPaginationLoading extends ChatState {
  final List<Chat> chats;
  final List<PaginationLink> pagination;
  ChatPaginationLoading({required this.chats, required this.pagination});
}
final class ChatPaginationError extends ChatState {
  final String message;
  final List<Chat> chats;
  final List<PaginationLink> pagination;
  ChatPaginationError({
    required this.message,
    required this.chats,
    required this.pagination,
  });
}