import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/information/network/modal/aadhaar_card_verify_modal.dart';
import 'package:salarynow/utils/written_text.dart';

import '../../../../service_helper/api/dio_api.dart';
import '../../../../service_helper/error_helper.dart';
import '../../../../service_helper/modal/error_modal.dart';
import '../../../network/api/residential_api/residential_details_api.dart';

part 'aadhaar_card_verification_state.dart';

class AadhaarCardVerificationCubit extends Cubit<AadhaarCardVerificationState> {
  AadhaarCardVerificationCubit() : super(AadhaarCardVerificationInitial());

  static AadhaarCardVerificationCubit get(context) => BlocProvider.of(context);

  final api = ResidentialDetailsApi(DioApi(isHeader: true).sendRequest);

  Future postAadhaarVerification({required String clientID, required String otp}) async {
    var data = {
      "client_id": clientID,
      "otp": otp,
    };
    try {
      emit(AadhaarCardVerificationLoading());
      final res = await api.postAadhaarVerification(data);

      if (res.response.statusCode == 200) {
        AadhaarCardVerifyModal modal = AadhaarCardVerifyModal.fromJson(data);
        emit(AadhaarCardVerificationLoaded(aadhaarCardVerifyModal: modal));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(AadhaarCardVerificationError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(AadhaarCardVerificationError(error: handleDioError(e)));
    } catch (e) {
      emit(AadhaarCardVerificationError(error: MyWrittenText.somethingWrong));
    }
  }
}
