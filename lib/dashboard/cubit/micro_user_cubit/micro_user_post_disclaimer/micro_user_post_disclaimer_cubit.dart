import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/utils/written_text.dart';

import '../../../../service_helper/api/dio_api.dart';
import '../../../../service_helper/error_helper.dart';
import '../../../../service_helper/modal/error_modal.dart';
import '../../../network/api/dashboard_api.dart';
import '../../../network/modal/micro_user_post_disclaimer_modal.dart';

part 'micro_user_post_disclaimer_state.dart';

class MicroUserPostDisclaimerCubit extends Cubit<MicroUserPostDisclaimerState> {
  MicroUserPostDisclaimerCubit() : super(MicroUserPostDisclaimerInitial());

  static MicroUserPostDisclaimerCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future postMicroDisclaimer({required String loanId, required String checkStatus}) async {
    try {
      emit(MicroUserPostDisclaimerLoading());
      final res = await api.postMicroUserDisclaimer({"loanId": loanId, "check_status": checkStatus});

      if (res.response.statusCode == 200) {
        MicroUserPostDisclaimerModal model = MicroUserPostDisclaimerModal.fromJson(res.data);
        emit(MicroUserPostDisclaimerLoaded(modal: model));
      } else if (res.response.statusCode == 400) {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(MicroUserPostDisclaimerError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(MicroUserPostDisclaimerError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(MicroUserPostDisclaimerError(error: MyWrittenText.somethingWrong));
    }
  }
}
