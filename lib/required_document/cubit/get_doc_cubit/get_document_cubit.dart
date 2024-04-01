import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/required_document/network/modal/accomodation_req_modal.dart';
import 'package:salarynow/required_document/network/modal/bank_statement_modal.dart';
import 'package:salarynow/required_document/network/modal/salary_slip_modal.dart';
import 'package:salarynow/required_document/network/modal/adress_proof_modal.dart';
import 'package:salarynow/utils/written_text.dart';

import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/api/req_document_api.dart';
import '../../network/modal/document_get_modal.dart';

part 'get_document_state.dart';

class GetDocumentCubit extends Cubit<GetDocumentState> {
  GetDocumentCubit() : super(GetDocumentInitial());

  static GetDocumentCubit get(context) => BlocProvider.of(context);

  final api = ReqDocumentApi(DioApi(isHeader: true).sendRequest);

  Future getDocument({String? doctype}) async {
    emit(GetDocumentLoading());
    try {
      final res = await api.getDocument({"doctype": doctype});

      if (res.response.statusCode == 200) {
        if (doctype == 'salary_slip') {
          SalarySlipModal model = SalarySlipModal.fromJson(res.data);
          emit(SalarySlipLoaded(modal: model));
        } else if (doctype == 'bank_statement') {
          BankStatementModal model = BankStatementModal.fromJson(res.data);
          emit(BankStatementLoaded(modal: model));
        } else if (doctype == 'rent_agreement_file') {
          AccomodationReqModal model = AccomodationReqModal.fromJson(res.data);
          emit(AccommodationReqLoaded(modal: model));
        } else if (doctype == 'address_proof') {
          AddressProofModal model = AddressProofModal.fromJson(res.data);
          emit(AddressProofLoaded(modal: model));
        } else {
          DocumentGetModal model = DocumentGetModal.fromJson(res.data);
          emit(GetDocumentLoaded(modal: model));
        }
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(GetDocumentError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(GetDocumentError(error: handleDioError(e)));
    } catch (e) {
      emit(GetDocumentError(error: MyWrittenText.somethingWrong));
    }
  }

  @override
  Future<void> close() {
    getDocument();
    return super.close();
  }
}
