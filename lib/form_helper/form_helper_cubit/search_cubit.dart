import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<String> {
  SearchCubit() : super('');

  void updateSearchQuery(String newQuery) {
    emit(newQuery);
  }

  @override
  Future<void> close() {
    updateSearchQuery("");
    return super.close();
  }
}
