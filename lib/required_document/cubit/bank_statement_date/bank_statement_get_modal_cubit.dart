import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/required_document/network/modal/bank_statement_modal_date.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/api/req_document_api.dart';

part 'bank_statement_get_modal_state.dart';

class BankStatementGetCubit extends Cubit<BankStatementGetState> {
  BankStatementGetCubit() : super(BankStatementGetInitial()) {
    // BankStatementGetCubit();
  }

  static BankStatementGetCubit get(context) => BlocProvider.of(context);

  final api = ReqDocumentApi(DioApi(isHeader: true).sendRequest);
  Future getDate() async {
    try {
      emit(BankStatementGetLoading());
      final res = await api.getBankStatementDate();

      if (res.response.statusCode == 200) {
        BankStatementDateModal model = BankStatementDateModal.fromJson(res.data);
        emit(BankStatementGetLoaded(bankStatementModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(BankStatementGetError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(BankStatementGetError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(BankStatementGetError(error: MyWrittenText.somethingWrong));
    }
  }
}
