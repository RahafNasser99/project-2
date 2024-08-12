import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit() : super(GetMessagesInitial());
}
