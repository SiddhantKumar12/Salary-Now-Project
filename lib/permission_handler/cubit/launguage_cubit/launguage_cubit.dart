import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/permission_handler/api/permission_api.dart';
import 'package:salarynow/service_helper/modal/error_modal.dart';
import 'package:salarynow/utils/written_text.dart';

import '../../../boarding/api/on_boarding_api.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../storage/local_storage.dart';
import '../../../storage/local_storage_strings.dart';

part 'launguage_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  static LanguageCubit get(context) => BlocProvider.of(context);
  final api = PermissionApi(DioApi(isHeader: false).sendRequest);
  String? appId = MyStorage.readData(MyStorageString.uuid);

  Future postLanguage({required String language}) async {
    try {
      emit(LanguageLoading());

      var data = {
        "language": language,
        "app_id": appId ?? '',
      };
      final res = await api.postLanguage(data);

      if (res.response.statusCode == 200) {
        ErrorModal model = ErrorModal.fromJson(res.data);
        emit(LanguageLoaded(modal: model));
      } else if (res.response.statusCode == 400) {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(LanguageError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(LanguageError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(LanguageError(error: MyWrittenText.somethingWrong));
    }
  }
}
