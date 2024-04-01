import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/utils/written_text.dart';

import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../../permission_handler/api/permission_api.dart';

part 'contact_ref_state.dart';

class ContactRefCubit extends Cubit<ContactRefState> {
  ContactRefCubit() : super(ContactRefInitial());

  static ContactRefCubit get(context) => BlocProvider.of(context);
  final api = PermissionApi(DioApi(isHeader: true).sendRequest);

  Future postContactRef({var data}) async {
    try {
      emit(ContactRefLoading());
      final res = await api.postContactRef(data);

      if (res.response.statusCode == 200) {
        ErrorModal model = ErrorModal.fromJson(res.data);
        emit(ContactRefLoaded(errorModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(ContactRefError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(ContactRefError(error: handleDioError(e)));
    } catch (e) {
      emit(ContactRefError(error: MyWrittenText.somethingWrong));
    }
  }
}
