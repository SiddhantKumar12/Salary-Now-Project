import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/dashboard/network/api/dashboard_api.dart';
import 'package:salarynow/dashboard/network/modal/sanction_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';

part 'get_sanction_state.dart';

class SanctionCubit extends Cubit<SanctionState> {
  SanctionCubit() : super(SanctionInitial());

  static SanctionCubit get(context) => BlocProvider.of(context);

  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future postSanctionPdf(String loanNumber) async {
    try {
      emit(SanctionLoading());
      final res = await api.postSanctionPdf({"loan_id": loanNumber});

      if (res.response.statusCode == 200) {
        SanctionModal model = SanctionModal.fromJson(res.data);
        emit(SanctionLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(SanctionError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(SanctionError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(SanctionError(error: MyWrittenText.somethingWrong));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
