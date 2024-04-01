import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/reference_number/network/contact_ref_status_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../../permission_handler/api/permission_api.dart';

part 'contact_ref_status_state.dart';

class ContactRefStatusCubit extends Cubit<ContactRefStatusState> {
  ContactRefStatusCubit() : super(ContactRefStatusInitial());

  static ContactRefStatusCubit get(context) => BlocProvider.of(context);

  final api = PermissionApi(DioApi(isHeader: true).sendRequest);

  Future getContactRef() async {
    try {
      emit(ContactRefStatusLoading());
      final res = await api.getContactRefStatus();

      if (res.response.statusCode == 200) {
        ContactRefStatusModal model = ContactRefStatusModal.fromJson(res.data);
        emit(ContactRefStatusLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(ContactRefStatusError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(ContactRefStatusError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(ContactRefStatusError(error: MyWrittenText.somethingWrong));
    }
  }
}
