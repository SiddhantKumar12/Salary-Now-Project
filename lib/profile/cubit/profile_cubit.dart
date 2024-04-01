import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:salarynow/profile/network/api/profile_api.dart';
import 'package:salarynow/profile/network/modal/profile_modal.dart';
import 'package:salarynow/service_helper/api/dio_api.dart';
import 'package:salarynow/storage/local_storage.dart';
import 'package:salarynow/storage/local_user_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../service_helper/error_helper.dart';
import '../../service_helper/modal/error_modal.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final api = ProfileApi(DioApi(isHeader: true).sendRequest);

  Future getProfile() async {
    try {
      emit(ProfileLoading());
      final res = await api.getProfile();

      if (res.response.statusCode == 200) {
        ProfileModal model = ProfileModal.fromJson(res.data);
        emit(ProfileLoaded(profileModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(ProfileError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(ProfileError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(ProfileError(error: MyWrittenText.somethingWrong));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
