import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/information/network/api/banking_api/banking_detail_api.dart';
import 'package:salarynow/information/network/api/employment_api/emp_detail_api.dart';
import 'package:salarynow/information/network/api/residential_api/residential_details_api.dart';
import 'package:salarynow/utils/written_text.dart';

import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/api/personal_detail_api/personal_details_api.dart';
import '../../network/modal/banking_detail_modal.dart';
import '../../network/modal/emp_detail_modal.dart';
import '../../network/modal/personal_info_modal.dart';
import '../../network/modal/residential_modal.dart';

part 'update_info_state.dart';

class UpdateInfoCubit extends Cubit<UpdateInfoState> {
  UpdateInfoCubit() : super(UpdateInfoInitial());

  static UpdateInfoCubit get(context) => BlocProvider.of(context);

  final personalApi = PersonalDetailsApi(DioApi(isHeader: true).sendRequest);
  final professionalApi = EmpDetailApi(DioApi(isHeader: true).sendRequest);
  final residentialDetailsApi = ResidentialDetailsApi(DioApi(isHeader: true).sendRequest);
  final bankingDetailApi = BankingDetailApi(DioApi(isHeader: true).sendRequest);

  Future updatePersonalDetails({
    String? alterMobile,
    String? fatherName,
    String? gender,
    String? martialStatus,
    String? emRelation1,
    String? relationName1,
    String? relationMobile1,
    String? emRelation2,
    String? relationName2,
    String? relationMobile2,
    String? fullName,
    String? panNo,
    String? dob,
    bool? relationStatus,
  }) async {
    var data = {
      "alterMobile": alterMobile,
      "father_name": fatherName,
      "gender": gender,
      "marital_status": martialStatus,
      "emprelationship1": emRelation1,
      "relationName1": relationName1,
      "relationMobile1": relationMobile1,
      "emprelationship2": emRelation2,
      "relationName2": relationName2,
      "relationMobile2": relationMobile2,
      "fullname": fullName,
      "pan_no": panNo,
      "dob": dob,
      "relation_status": relationStatus
    };
    try {
      emit(UpdatePersonalInfoLoading());
      final res = await personalApi.updatePersonalDetails(data);

      if (res.response.statusCode == 200) {
        PersonalDetailsModal model = PersonalDetailsModal.fromJson(res.data);
        emit(UpdatePersonalInfoLoaded(personalDetailsModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(UpdatePersonalInfoError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(UpdatePersonalInfoError(error: handleDioError(e).toString()));
    }
  }

  Future updateEmpDetails({
    String? companyName,
    String? designation,
    String? salary,
    String? salaryMode,
    String? officeAddress,
    String? officeCityId,
    String? officeStateId,
    String? officePinCode,
    String? salaryDate,
    String? education,
    String? workingEmail,
    // String? noMonthWork,
    String? empType,
    bool? salaryChecked,
  }) async {
    var data = {
      "company_name": companyName,
      "designation": designation,
      "salary": salary,
      "salary_mode": salaryMode,
      "office_address": officeAddress,
      "office_city": officeCityId,
      "office_state": officeStateId,
      "office_pincode": officePinCode,
      "salary_date": salaryDate,
      "education": education,
      "workingemail": workingEmail,
      // "nomonthwork": noMonthWork,
      "employment_type": empType,
      "micro_status": salaryChecked
    };
    try {
      emit(UpdateEmpDetailLoading());
      final res = await professionalApi.updateEmpDetails(data);

      if (res.response.statusCode == 200) {
        EmpDetailModal model = EmpDetailModal.fromJson(res.data);
        emit(UpdateEmpDetailLoaded(empDetailModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(UpdateEmpDetailError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(UpdateEmpDetailError(error: handleDioError(e).toString()));
    }
  }

  Future updateResidentialDetails({
    String? resiStatus,
    String? landmark,
    String? curAdd,
    String? curCity,
    String? curState,
    String? curPinCode,
    String? perCity,
    String? perState,
    String? perPinCode,
    String? perAdd,
  }) async {
    var data = {
      "residencial_status": resiStatus,
      "cur_landmark": landmark,
      "cur_address1": curAdd,
      "cur_city": curCity,
      "cur_state": curState,
      "cur_pincode": curPinCode,
      "perm_address": perAdd,
      "perm_pincode": perPinCode,
      "perm_state": perState,
      "perm_city": perCity
    };
    try {
      emit(UpdateResiDetailLoading());
      final res = await residentialDetailsApi.updateResidentialDetails(data);

      if (res.response.statusCode == 200) {
        ResidentialDetailsModal model = ResidentialDetailsModal.fromJson(res.data);
        emit(UpdateResiDetailLoaded(residentialDetailsModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(UpdateResiDetailError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(UpdateResiDetailError(error: handleDioError(e).toString()));
    }
  }

  Future updateBankDetails(
      {String? bankID, String? bankName, String? branchName, String? ifsc, String? accountNo}) async {
    var updateBody = {
      "bankid": bankID,
      "bank_name": bankName,
      "branch_name": branchName,
      "ifsc": ifsc,
      "account_no": accountNo
    };
    try {
      emit(UpdateBankDetailLoading());
      final res = await bankingDetailApi.updateBankDetails(updateBody);

      if (res.response.statusCode == 200) {
        BankDetailsModal model = BankDetailsModal.fromJson(res.data);
        emit(UpdateBankDetailLoaded(bankDetailsModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(UpdateBankDetailError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(UpdateBankDetailError(error: handleDioError(e)));
    } catch (e) {
      emit(UpdateBankDetailError(error: MyWrittenText.somethingWrong));
    }
  }
}
