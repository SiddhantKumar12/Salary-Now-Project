import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:salarynow/Notification/cubit/get_notifiction/get_notification_cubit.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/widgets/empty_container.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../widgets/text_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const InfoCustomAppBar(title: 'Notification'),
        body: BlocProvider(
          create: (context) => GetNotificationCubit(),
          child: BlocConsumer<GetNotificationCubit, GetNotificationState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetNotificationLoaded) {
                return state.notificationGetModal.responseData!.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: () {
                          var cubit = GetNotificationCubit.get(context);
                          return cubit.getNotification();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 15.h,
                            right: 15.w,
                            left: 15.w,
                          ),
                          child: ListView.builder(
                              // separatorBuilder: (BuildContext context, int index) => const Divider(),
                              itemCount: state.notificationGetModal.responseData?.length ?? 0,
                              itemBuilder: (context, index) {
                                var data = state.notificationGetModal.responseData;
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Card(
                                    elevation: 2,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h, right: 15.w),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.mail_outline,
                                                  color: MyColor.turcoiseColor,
                                                  size: 30.sp,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            flex: 6,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: MyText(
                                                        text: data?[index].title ?? '',
                                                        maxLines: 1,
                                                        textOverflow: TextOverflow.ellipsis,
                                                        overflow: TextOverflow.ellipsis,
                                                        color: MyColor.turcoiseColor,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: MyText(
                                                          fontSize: 12.sp,
                                                          textAlign: TextAlign.right,
                                                          fontWeight: FontWeight.w300,
                                                          text: getTime(
                                                            data?[index].insertdatetime ?? '',
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.h),
                                                MyText(
                                                  // maxLines: 4,
                                                  text: data?[index].message ?? '',
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w300,
                                                  // color: MyColor.subtitleTextColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                // return ListTile(
                                //   title: MyText(text: data?[index].title ?? '', fontSize: 18.sp),
                                //   subtitle: MyText(
                                //     text: data?[index].message ?? '',
                                //     fontSize: 16.sp,
                                //     color: MyColor.subtitleTextColor,
                                //   ),
                                //   trailing: MyText(text: getTime(data?[index].insertdatetime ?? '')),
                                // );
                              }),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            EmptyContainer(text: 'No Notification'),
                          ],
                        ),
                      );
              } else if (state is GetNotificationLoading) {
                return const MyLoader();
              } else {
                return MyErrorWidget(onPressed: () {
                  var cubit = GetNotificationCubit.get(context);
                  cubit.getNotification();
                });
              }
            },
          ),
        ),
      ),
    );
  }

  String getTime(String date) {
    String dateString = date.substring(0, 19) + date.substring(19, 22).toUpperCase();
    DateTime dateTime = DateFormat('yyyy-MM-dd hh:mm:ss a').parse(dateString);
    String formattedDateTime = DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);
    DateTime dateTime2 = DateFormat('yyyy-MM-dd hh:mm:ss a').parse(formattedDateTime);
    String timeAgo = timeago.format(dateTime2);
    return timeAgo;
  }
}
