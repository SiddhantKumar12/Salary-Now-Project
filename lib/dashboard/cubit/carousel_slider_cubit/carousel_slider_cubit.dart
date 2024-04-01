import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/api/dashboard_api.dart';
import '../../network/modal/carousel_slider_modal.dart';

part 'carousel_slider_state.dart';

class CarouselSliderCubit extends Cubit<CarouselSliderState> {
  CarouselSliderCubit() : super(CarouselSliderInitial());

  static CarouselSliderCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future getCarouselUrl() async {
    try {
      emit(CarouselSliderLoading());
      final res = await api.getCarouselSlider();

      if (res.response.statusCode == 200) {
        CarouselSliderModal model = CarouselSliderModal.fromJson(res.data);
        emit(CarouselSliderLoaded(carouselSliderModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(CarouselSliderError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(CarouselSliderError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(CarouselSliderError(error: MyWrittenText.somethingWrong));
    }
  }
}
