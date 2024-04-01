import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../service_helper/api/dio_api.dart';
import '../../service_helper/error_helper.dart';
import '../../service_helper/modal/error_modal.dart';
import '../network/api/form_helper_api.dart';
import '../network/modal/bank_list_modal.dart';

part 'bank_list_state.dart';

class BankListCubit extends Cubit<BankListState> {
  BankListCubit() : super(BankListInitial()) {}

  static BankListCubit get(context) => BlocProvider.of(context);

  final api = FormHelperApi(DioApi(isHeader: false).sendRequest);

  Future getBankList() async {
    try {
      emit(BankListLoadingState());
      final res = await api.postBankList();

      if (res.response.statusCode == 200) {
        BankListModal model = BankListModal.fromJson(res.data);
        emit(BankListLoadedState(model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(BankListErrorState(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(BankListErrorState(error: handleDioError(e).toString()));
    } catch (e) {
      emit(BankListErrorState(error: MyWrittenText.somethingWrong));
    }
  }
}
