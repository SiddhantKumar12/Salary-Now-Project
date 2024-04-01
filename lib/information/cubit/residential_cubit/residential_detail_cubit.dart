import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/information/network/api/residential_api/residential_details_api.dart';
import 'package:salarynow/information/network/modal/residential_modal.dart';
import 'package:salarynow/service_helper/error_helper.dart';
import 'package:salarynow/utils/written_text.dart';

import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/modal/error_modal.dart';

part 'residential_detail_state.dart';

class ResiDetailCubit extends Cubit<ResiDetailState> {
  ResiDetailCubit() : super(ResidentialDetailInitial()) {
    getResidentialDetails();
  }

  static ResiDetailCubit get(context) => BlocProvider.of(context);

  final api = ResidentialDetailsApi(DioApi(isHeader: true).sendRequest);

  Future getResidentialDetails() async {
    try {
      emit(ResidentialDetailLoading());
      final res = await api.getResidentialDetails();

      if (res.response.statusCode == 200) {
        ResidentialDetailsModal model = ResidentialDetailsModal.fromJson(res.data);
        emit(ResidentialDetailLoaded(residentialDetailsModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(ResidentialDetailError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(ResidentialDetailError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(ResidentialDetailError(error: MyWrittenText.somethingWrong));
    }
  }

  @override
  Future<void> close() {
    getResidentialDetails();
    return super.close();
  }
}
