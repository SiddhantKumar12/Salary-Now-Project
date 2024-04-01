import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImagePickerCubit extends Cubit<Map<String, String>> {
  ImagePickerCubit() : super({});

  static ImagePickerCubit get(context) => BlocProvider.of(context);

  Future<void> pickImage(String key, ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource, imageQuality: 50);

    if (pickedFile != null) {
      final croppedFile = await _cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        final imageBytes = await croppedFile.readAsBytes();
        final base64Image = base64Encode(imageBytes);
        emit({...state, key: base64Image});
      }
    }
  }

  void removeImage(String key) {
    emit({...state, key: key});
  }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    final cropper = ImageCropper();
    final croppedFile = await cropper.cropImage(compressQuality: 50, sourcePath: imageFile.path, aspectRatioPresets: [
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9,
    ]);
    return croppedFile;
  }
}
