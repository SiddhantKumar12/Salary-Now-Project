import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/form_helper/network/modal/doc_address_type.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../service_helper/api/dio_api.dart';
import '../../service_helper/error_helper.dart';
import '../../service_helper/modal/error_modal.dart';
import '../../storage/local_storage.dart';
import '../network/api/doc_api/document_api.dart';
import '../network/modal/doc_accomodation_modal.dart';

part 'document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  DocumentCubit() : super(DocumentInitial());

  static DocumentCubit get(context) => BlocProvider.of(context);

  final api = DocumentApi(DioApi(isHeader: true).sendRequest);

  /// Doc Type Address Modal
  Future getDocAddType() async {
    try {
      emit(DocAddTypeLoading());
      final res = await api.getDocAddType();

      if (res.response.statusCode == 200) {
        DocAddressTypeModal model = DocAddressTypeModal.fromJson(res.data);
        MyStorage.setAddressModal(model);

        emit(DocAddTypeLoaded(docAddressTypeModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(DocAddTypeError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(DocAddTypeError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(DocAddTypeError(error: MyWrittenText.somethingWrong));
    }
  }

  /// Doc Accomodation Modal
  Future getAccomodationType() async {
    try {
      emit(DocAccomodationLoading());
      final res = await api.getAccomodationType();

      if (res.response.statusCode == 200) {
        DocAccomodationModal model = DocAccomodationModal.fromJson(res.data);
        MyStorage.setAccomadationModal(model);
        emit(DocAccomodationLoaded(docAccomodationModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(DocAddTypeError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(DocAddTypeError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(DocAddTypeError(error: MyWrittenText.somethingWrong));
    }
  }
}
