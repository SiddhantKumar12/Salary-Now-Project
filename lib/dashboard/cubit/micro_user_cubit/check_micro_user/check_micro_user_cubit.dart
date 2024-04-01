import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/dashboard/network/modal/check_micro_user_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../../service_helper/api/dio_api.dart';
import '../../../../service_helper/error_helper.dart';
import '../../../../service_helper/modal/error_modal.dart';
import '../../../network/api/dashboard_api.dart';

part 'check_micro_user_state.dart';

class CheckMicroUserCubit extends Cubit<CheckMicroUserState> {
  CheckMicroUserCubit() : super(CheckMicroUserInitial());

  static CheckMicroUserCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future getCheckMicro() async {
    try {
      emit(CheckMicroUserLoading());
      final res = await api.getCheckMicroUser();

      if (res.response.statusCode == 200) {
        CheckMicroUserModal model = CheckMicroUserModal.fromJson(res.data);

        emit(CheckMicroUserLoaded(checkMicroUserModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(CheckMicroUserError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(CheckMicroUserError(error: MyWrittenText.somethingWrong));
    }
  }
}
