import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../storage/local_storage.dart';
import '../../../storage/local_storage_strings.dart';

part 'file_picker_state.dart';

class FilePickerCubit extends Cubit<FilePickerState> {
  FilePickerCubit() : super(PdfPickerInitial());

  static FilePickerCubit get(context) => BlocProvider.of(context);

  void pickFile({bool? isPdf = false}) async {
    emit(FilePickerLoading());

    PermissionStatus permissionStatus = await Permission.storage.request();
    PermissionStatus photoPermission = await Permission.photos.request();

    String version = MyStorage.readData(MyStorageString.androidVersion);

    if (int.parse(version.substring(version.length - 2).toString()) <= 12) {
      if (permissionStatus == PermissionStatus.granted) {
        pickFileFunction(isPdf: isPdf);
      } else {
        emit(FilePickerError(error: 'Storage Permission Denied'));
      }
    } else {
      // if (photoPermission.isGranted) {
      pickFileFunction(isPdf: isPdf);
      // } else {
      //   emit(FilePickerError(error: 'Can\'t Upload File'));
      // }
    }
  }

  Future<void> pickFileFunction({bool? isPdf}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: isPdf == true ? ['pdf'] : ['pdf', 'jpeg', 'jpg', 'png'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      int fileSizeInBytes = await file.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 25) {
        emit(FilePickerError(error: 'File size exceeds 25 MB'));
      } else {
        String extension = result.files.single.extension!;
        final base64String = await _getBase64String(file);
        emit(FilePickerSuccess(file: file, extension: extension, base64: base64String));
      }
    } else {
      emit(FilePickerError(error: 'File not picked'));
    }
  }

  void reset() {
    emit(PdfPickerInitial());
  }

  Future<String> _getBase64String(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  @override
  Future<void> close() {
    emit(PdfPickerInitial());
    return super.close();
  }
}
