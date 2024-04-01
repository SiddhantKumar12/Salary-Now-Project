part of 'file_picker_cubit.dart';

@immutable
abstract class FilePickerState {}

class PdfPickerInitial extends FilePickerState {}

class FilePickerLoading extends FilePickerState {}

class FilePickerSuccess extends FilePickerState {
  final File file;
  final String extension;
  final String base64;

  FilePickerSuccess({required this.file, required this.base64, required this.extension});
}

class FilePickerError extends FilePickerState {
  final String error;

  FilePickerError({required this.error});
}
