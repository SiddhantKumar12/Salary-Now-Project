import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofit/dio.dart';
import 'package:salarynow/required_document/network/modal/req_document_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/api/req_document_api.dart';

part 'req_document_state.dart';

class ReqDocumentCubit extends Cubit<ReqDocumentState> {
  ReqDocumentCubit() : super(ReqDocumentInitial());

  static ReqDocumentCubit get(context) => BlocProvider.of(context);

  final api = ReqDocumentApi(DioApi(isHeader: true).sendRequest);

  Future postDocument(
      {String? file1,
      String? file2,
      String? type,
      String? startDate,
      String? endDate,
      String? resiStatus,
      String? extension,
      String? password,
      String? month,
      String? docType}) async {
    emit(ReqDocumentLoading());

    try {
      Map<String, dynamic> data = {};

      if (type == 'id_proof_file') {
        data = {"file1": file1, "file2": file2, "type": type};
      } else if (type == 'pan_card') {
        data = {"file1": file1, "file2": file2, "type": type};
      } else if (type == 'address_proof') {
        data = {"file1": file1, "file2": file2, "type": type, "document_type": docType};
      } else if (type == 'rent_agreement_file') {
        data = {
          "file1": file1,
          "file2": file2,
          "type": type,
          "residential_status": resiStatus,
          "document_type": docType
        };
      } else {
        data = {"file1": file1, "file2": file2, "type": type, "start_date": startDate, "end_date": endDate};
      }

      final res = await api.postAadhaarCard(data);

      if (res.response.statusCode == 200) {
        ReqDocumentModal model = ReqDocumentModal.fromJson(res.data);
        emit(ReqDocumentLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(ReqDocumentError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(ReqDocumentError(error: handleDioError(e)));
    } catch (e) {
      emit(ReqDocumentError(error: MyWrittenText.somethingWrong));
    }
  }

  Future postStatement({
    File? file,
    String? month,
    String? type,
    String? startDate,
    String? endDate,
    String? password,
  }) async {
    emit(ReqDocumentLoading());

    FormData? formData;
    final HttpResponse res;
    try {
      if (type == 'salary_slip') {
        formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            file!.path,
            filename: file.path.split('/').last,
          ),
          'month': month,
          'type': type
        });
      } else {
        formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            file!.path,
            filename: file.path.split('/').last,
          ),
          'month': month,
          'type': type,
          'start_date': startDate,
          'end_date': endDate,
          'password': password
        });
      }

      res = await api.uploadStatement(formData);

      if (res.response.statusCode == 200) {
        ReqDocumentModal model = ReqDocumentModal.fromJson(res.data);
        emit(ReqDocumentLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(ReqDocumentError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(ReqDocumentError(error: handleDioError(e)));
    } catch (e) {
      emit(ReqDocumentError(error: MyWrittenText.somethingWrong));
    }
  }

  Future postSelfie({File? file, String? location, String? longitude, String? latitude}) async {
    emit(ReqDocumentLoading());

    FormData? formData;
    final HttpResponse res;
    try {
      formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file!.path,
          filename: file.path.split('/').last,
        ),
        'selfie_location': location,
        'longitude': longitude,
        'latitude': latitude
      });
      res = await api.uploadSelfie(formData);

      if (res.response.statusCode == 200) {
        ReqDocumentModal model = ReqDocumentModal.fromJson(res.data);
        emit(ReqDocumentLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(ReqDocumentError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(ReqDocumentError(error: handleDioError(e)));
    } catch (e) {
      emit(ReqDocumentError(error: MyWrittenText.somethingWrong));
    }
  }

  @override
  Future<void> close() {
    postDocument();
    postStatement();
    postSelfie();
    return super.close();
  }
}
