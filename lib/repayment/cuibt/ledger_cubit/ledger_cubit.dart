import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/repayment/network/modal/ledger_modal.dart';

import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../../utils/written_text.dart';
import '../../network/api/repayment_api.dart';

part 'ledger_state.dart';

class LedgerCubit extends Cubit<LedgerState> {
  LedgerCubit() : super(LedgerInitial()) {
    getLedger();
  }

  static LedgerCubit get(context) => BlocProvider.of(context);

  final api = RepaymentApi(DioApi(isHeader: true).sendRequest);

  Future getLedger() async {
    try {
      emit(LedgerLoading());
      final res = await api.getLedger();

      if (res.response.statusCode == 200) {
        LedgerModal model = LedgerModal.fromJson(res.data);
        emit(LedgerLoaded(ledgerModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(LedgerError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(LedgerError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(LedgerError(error: MyWrittenText.somethingWrong));
    }
  }
}
