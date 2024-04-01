import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salarynow/packages/network/api/packages_api.dart';
import 'package:salarynow/packages/network/modal/packages_modal.dart';
import 'package:salarynow/service_helper/api/dio_api.dart';
import 'package:salarynow/utils/written_text.dart';

import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  PackagesCubit() : super(PackagesInitial()) {
    getPackages();
  }
  static PackagesCubit get(context) => BlocProvider.of(context);

  final api = PackagesApi(DioApi(isHeader: true).sendRequest);

  Future getPackages() async {
    try {
      emit(PackagesLoadingState());
      final res = await api.getPackages();

      if (res.response.statusCode == 200) {
        PackagesModal model = PackagesModal.fromJson(res.data);
        emit(PackagesLoadedState(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(PackagesErrorState(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(PackagesErrorState(error: handleDioError(e).toString()));
    } catch (e) {
      emit(PackagesErrorState(error: MyWrittenText.somethingWrong));
    }
  }
}
