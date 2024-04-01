import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/dashboard/network/modal/religion_form_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/api/dashboard_api.dart';

part 'religion_form_state.dart';

class ReligionFormCubit extends Cubit<ReligionFormState> {
  ReligionFormCubit() : super(ReligionFormInitial());

  static ReligionFormCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future getReligionData() async {
    try {
      emit(ReligionFormLoading());
      final res = await api.getUserReligion();

      if (res.response.statusCode == 200) {
        ReligionFormModal model = ReligionFormModal.fromJson(res.data);
        emit(ReligionFormLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(ReligionFormError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(ReligionFormError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(ReligionFormError(error: MyWrittenText.somethingWrong));
    }
  }
}
