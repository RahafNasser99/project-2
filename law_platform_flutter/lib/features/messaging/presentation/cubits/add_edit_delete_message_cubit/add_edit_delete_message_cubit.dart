import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:law_platform_flutter/features/messaging/domain/usecases/add_message_usecase.dart';
import 'package:law_platform_flutter/features/messaging/domain/usecases/edit_message_usecase.dart';
import 'package:law_platform_flutter/features/messaging/domain/usecases/delete_message_usecase.dart';

part 'add_edit_delete_message_state.dart';

class AddEditDeleteMessageCubit extends Cubit<AddEditDeleteMessageState> {
  AddMessageUsecase addMessageUsecase = AddMessageUsecase();
  EditMessageUsecase editMessageUsecase = EditMessageUsecase();
  DeleteMessageUsecase deleteMessageUsecase = DeleteMessageUsecase();

  AddEditDeleteMessageCubit() : super(AddEditDeleteMessageInitial());

  
}
