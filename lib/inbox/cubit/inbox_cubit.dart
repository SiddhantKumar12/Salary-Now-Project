import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'inbox_state.dart';

class InboxCubit extends Cubit<InboxState> {
  InboxCubit() : super(InboxInitial());
}
