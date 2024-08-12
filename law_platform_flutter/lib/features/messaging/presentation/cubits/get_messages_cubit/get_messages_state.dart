part of 'get_messages_cubit.dart';

sealed class GetMessagesState extends Equatable {
  const GetMessagesState();

  @override
  List<Object> get props => [];
}

final class GetMessagesInitial extends GetMessagesState {}
