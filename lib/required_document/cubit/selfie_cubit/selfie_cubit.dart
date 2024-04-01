import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
part 'selfie_state.dart';

class SelfieCubit extends Cubit<SelfieState> {
  SelfieCubit() : super(SelfieInitial());

  static SelfieCubit get(context) => BlocProvider.of(context);

  Future<void> getSelfie(XFile? pickedFile) async {
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus == PermissionStatus.granted) {
      emit(SelfieLoadingState());
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        Placemark place = placeMarks[0];
        if (pickedFile != null) {
          final croppedFile = await _cropImage(File(pickedFile.path));
          if (croppedFile != null) {
            emit(SelfieLoadedState(
                file: File(croppedFile.path), position: position, place: getCompleteAddress(place: place)));
          } else {
            emit(SelfieErrorState(error: 'Selfie Image Not Selected'));
          }
        } else {
          emit(SelfieErrorState(error: 'Selfie Image Not Selected'));
        }
      } catch (e) {
        emit(SelfieErrorState(error: 'Selfie Upload Failed'));
      }
    } else {
      emit(SelfieErrorState(error: 'Location Permission Denied'));
    }
  }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    final cropper = ImageCropper();
    final croppedFile = await cropper.cropImage(
      compressQuality: 50,
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    return croppedFile;
  }

  String getCompleteAddress({required Placemark place}) {
    return "${place.name!.isNotEmpty ? place.name : ""},"
        "${place.street!.isNotEmpty ? place.street : ""},"
        "${place.subLocality!.isNotEmpty ? place.subLocality : ""},"
        "${place.locality!.isNotEmpty ? place.locality : ""},"
        "${place.administrativeArea!.isNotEmpty ? place.administrativeArea : ""},"
        "${place.subAdministrativeArea!.isNotEmpty ? place.subAdministrativeArea : ""},"
        "${place.postalCode!.isNotEmpty ? place.postalCode : ""},"
        "${place.isoCountryCode!.isNotEmpty ? place.isoCountryCode : ""},"
        "${place.country!.isNotEmpty ? place.country : ""},"
        "${place.thoroughfare!.isNotEmpty ? place.thoroughfare : ""},"
        "${place.subThoroughfare!.isNotEmpty ? place.subThoroughfare : ""}";
  }
}
