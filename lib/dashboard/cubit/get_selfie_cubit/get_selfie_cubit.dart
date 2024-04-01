import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/dashboard/network/api/dashboard_api.dart';
import 'package:salarynow/required_document/network/modal/selfie_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../../storage/local_storage.dart';

part 'get_selfie_state.dart';

class GetSelfieCubit extends Cubit<GetSelfieState> {
  GetSelfieCubit() : super(GetSelfieInitial());

  static GetSelfieCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future getSelfie({String? doctype}) async {
    emit(GetSelfieLoading());
    try {
      final res = await api.getDocument({"doctype": doctype});

      if (res.response.statusCode == 200) {
        SelfieModal model = SelfieModal.fromJson(res.data);

        /// Local Selfie Storage
        MyStorage.setSelfieData(SelfieModal.fromJson(res.data));

        emit(GetSelfieLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(GetSelfieError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(GetSelfieError(error: handleDioError(e)));
    } catch (e) {
      emit(GetSelfieError(error: MyWrittenText.somethingWrong));
    }
  }
}
