import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/api/employment_api/emp_detail_api.dart';
import '../../network/modal/emp_detail_modal.dart';

part 'loan_emp_state.dart';

class LoanEmpCubit extends Cubit<LoanEmpState> {
  LoanEmpCubit() : super(LoanEmpInitial()) {
    getEmpDetails();
  }

  static LoanEmpCubit get(context) => BlocProvider.of(context);
  final api = EmpDetailApi(DioApi(isHeader: true).sendRequest);

  Future getEmpDetails() async {
    try {
      emit(LoanEmpLoading());
      final res = await api.getEmpDetails();

      if (res.response.statusCode == 200) {
        EmpDetailModal model = EmpDetailModal.fromJson(res.data);
        emit(LoanEmpLoaded(empDetailModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(LoanEmpError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(LoanEmpError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(LoanEmpError(error: MyWrittenText.somethingWrong));
    }
  }

  @override
  Future<void> close() {
    getEmpDetails();
    return super.close();
  }
}
