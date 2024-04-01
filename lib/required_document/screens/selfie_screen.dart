import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salarynow/widgets/dialog_box_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import '../../dashboard/cubit/get_selfie_cubit/get_selfie_cubit.dart';
import '../../profile/cubit/profile_cubit.dart';
import '../../utils/on_screen_loader.dart';
import '../../utils/snackbar.dart';
import '../../widgets/camera_button.dart';
import '../cubit/req_doc_cubit/req_document_cubit.dart';
import '../cubit/selfie_cubit/selfie_cubit.dart';

class SelfieScreen extends StatefulWidget {
  const SelfieScreen({Key? key}) : super(key: key);

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  late List<CameraDescription> cameras;
  CameraController? cameraController;

  int direction = 1;

  @override
  void initState() {
    startCamera(direction);
    super.initState();
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {}); //To refresh widget
    }).catchError((e) {
      MyDialogBox.openSelfiePermissionAppSetting(
          context: context,
          error: 'Give Camera permission',
          onPressed: () {
            openAppSettings();
            Navigator.pop(context);
            Navigator.pop(context);
          });
    });
  }

  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: cameraController == null
            ? const MyLoader()
            : cameraController!.value.isInitialized
                ? Stack(
                    children: [
                      CameraPreview(cameraController!),
                      BlocListener<ReqDocumentCubit, ReqDocumentState>(
                        listener: (context, state) {
                          if (state is ReqDocumentLoading) {
                            MyScreenLoader.onScreenLoader(context);
                          }
                          if (state is ReqDocumentError) {
                            Navigator.pop(context);
                            MySnackBar.showSnackBar(context, "Uploading Error");
                          }
                          if (state is ReqDocumentLoaded) {
                            MySnackBar.showSnackBar(context, "Selfie Image Uploaded");
                            Navigator.pop(context);
                            Navigator.pop(context);
                            var getSelfieCubit = GetSelfieCubit.get(context);
                            getSelfieCubit.getSelfie(doctype: 'selfie');
                            var profileCubit = ProfileCubit.get(context);
                            profileCubit.getProfile();
                          }
                        },
                        child: BlocListener<SelfieCubit, SelfieState>(
                          listener: (context, state) {
                            if (state is SelfieLoadingState) {
                              MyScreenLoader.onScreenLoader(context);
                            }
                            if (state is SelfieErrorState) {
                              Navigator.pop(context);
                              MySnackBar.showSnackBar(context, state.error);
                            }
                            if (state is SelfieLoadedState) {
                              Navigator.pop(context);
                              var selfieCubit = ReqDocumentCubit.get(context);

                              selfieCubit.postSelfie(
                                  location: state.place,
                                  file: state.file,
                                  latitude: state.position.latitude.toString(),
                                  longitude: state.position.longitude.toString());
                            }
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: MyCameraButton(onTap: () {
                                cameraController!.takePicture().then((XFile? file) {
                                  if (mounted) {
                                    var selfieCubit = SelfieCubit.get(context);
                                    selfieCubit.getSelfie(file);
                                  }
                                });
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const MyLoader());
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
