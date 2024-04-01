import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/information/network/modal/emp_detail_modal.dart';
import 'package:salarynow/service_helper/error_helper.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/api/employment_api/emp_detail_api.dart';

part 'employment_detail_state.dart';

class EmploymentDetailCubit extends Cubit<EmploymentDetailState> {
  EmploymentDetailCubit() : super(EmploymentDetailInitial()) {
    getEmpDetails();
  }

  static EmploymentDetailCubit get(context) => BlocProvider.of(context);
  final api = EmpDetailApi(DioApi(isHeader: true).sendRequest);

  Future getEmpDetails() async {
    try {
      emit(EmploymentDetailLoading());
      final res = await api.getEmpDetails();

      if (res.response.statusCode == 200) {
        EmpDetailModal model = EmpDetailModal.fromJson(res.data);
        emit(EmploymentDetailLoaded(empDetailModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(EmploymentDetailError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(EmploymentDetailError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(EmploymentDetailError(error: MyWrittenText.somethingWrong));
    }
  }

  @override
  Future<void> close() {
    getEmpDetails();
    return super.close();
  }
}
