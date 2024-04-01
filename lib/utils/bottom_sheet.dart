import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/dashboard/network/modal/religion_form_modal.dart';
import 'package:salarynow/form_helper/network/modal/bank_list_modal.dart';
import 'package:salarynow/form_helper/network/modal/city_modal.dart';
import 'package:salarynow/form_helper/network/modal/state_modal.dart';
import 'package:salarynow/form_helper/network/modal/user_common_modal.dart';
import 'package:salarynow/registration/network/modal/employment_type.dart';
import 'package:salarynow/utils/color.dart';
import '../form_helper/form_helper_cubit/search_cubit.dart';
import '../form_helper/network/modal/salary_mode.dart';
import '../widgets/text_widget.dart';

class MyBottomSheet {
  static final searchCubit = SearchCubit();

  static bankBotSheetWidget(
      {required BuildContext context,
      required String fieldSelected,
      required BankListModal bankListModal,
      required Function(String) onSelected,
      required Function(String) bankId}) {
    showModalBottomSheet<dynamic>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: searchCubit,
          child: DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 0.9,
              minChildSize: 0.2,
              expand: false,
              builder: (context, scrollController) {
                return Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: BlocBuilder<SearchCubit, String>(
                    builder: (context, searchQuery) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child:
                                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                              ),
                              MyText(text: "Bank List", fontSize: 24.h),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Search",
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                  onChanged: (newQuery) {
                                    searchCubit.updateSearchQuery(newQuery);
                                  },
                                ),
                              ),
                              ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: bankListModal.responseData?.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    int selectedValue = 0;
                                    if (fieldSelected == bankListModal.responseData![index].bankName) {
                                      selectedValue = int.parse(bankListModal.responseData![index].id!);
                                    }
                                    final itemName = "Item ${bankListModal.responseData![index].bankName}";
                                    if (searchQuery.isNotEmpty &&
                                        !itemName.toLowerCase().contains(searchQuery.toLowerCase())) {
                                      return const SizedBox.shrink();
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(bankListModal.responseData![index].bankName!);
                                        bankId(bankListModal.responseData![index].id!);
                                        searchCubit.updateSearchQuery("");
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: double.maxFinite,
                                        padding: EdgeInsets.only(left: 10.w),
                                        decoration: BoxDecoration(
                                            color: selectedValue == int.parse(bankListModal.responseData![index].id!)
                                                ? MyColor.highLightBlueColor
                                                : MyColor.transparentColor,
                                            borderRadius: BorderRadius.circular(15.r)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 300.w,
                                              child: MyText(
                                                text: bankListModal.responseData![index].bankName!,
                                                textAlign: TextAlign.start,
                                                fontSize: 14.sp,
                                                textOverflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Radio<int>(
                                              activeColor: MyColor.blackColor,
                                              value: int.parse(bankListModal.responseData![index].id!),
                                              groupValue: selectedValue,
                                              onChanged: (value) {
                                                selectedValue = value!;
                                                onSelected(bankListModal.responseData![index].bankName!);
                                                bankId(bankListModal.responseData![index].id!);
                                                searchCubit.updateSearchQuery("");
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
        );
      },
    );
  }

  static stateListSheetWidget(
      {required BuildContext context,
      required String fieldSelected,
      required StateModal stateList,
      required Function(String) onSelected,
      required Function(String) stateCode}) {
    showModalBottomSheet<dynamic>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: searchCubit,
          child: DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 0.9,
              minChildSize: 0.2,
              expand: false,
              snap: true,
              builder: (context, scrollController) {
                return BlocBuilder<SearchCubit, String>(
                  builder: (context, searchQuery) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child:
                                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                              ),
                              MyText(
                                text: stateList.responseMsg!,
                                fontSize: 24.h,
                              ),
                              SizedBox(height: 10.h),
                              stateList.responseData!.length <= 10
                                  ? SizedBox.shrink()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          hintText: "Search",
                                          prefixIcon: Icon(Icons.search),
                                        ),
                                        onChanged: (newQuery) {
                                          searchCubit.updateSearchQuery(newQuery);
                                        },
                                      ),
                                    ),
                              SizedBox(height: 10.h),
                              ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: stateList.responseData?.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var data = stateList.responseData;
                                    int selectedValue = 0;
                                    if (fieldSelected.toLowerCase() == data![index].state!.toLowerCase()) {
                                      selectedValue = int.parse(data[index].stateId!);
                                    }
                                    final itemName = "Item ${stateList.responseData![index].state}";
                                    if (searchQuery.isNotEmpty &&
                                        !itemName.toLowerCase().contains(searchQuery.toLowerCase())) {
                                      return const SizedBox.shrink();
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(data[index].state!);
                                        stateCode(data[index].stateId!);
                                        searchCubit.updateSearchQuery("");
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: double.maxFinite,
                                        padding: EdgeInsets.only(left: 10.w),
                                        decoration: BoxDecoration(
                                            color: selectedValue == int.parse(data[index].stateId!)
                                                ? MyColor.highLightBlueColor
                                                : MyColor.transparentColor,
                                            borderRadius: BorderRadius.circular(15.r)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 300.w,
                                              child: MyText(
                                                text: data[index].state!,
                                                textAlign: TextAlign.start,
                                                fontSize: 14.sp,
                                                textOverflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Radio<int>(
                                              activeColor: MyColor.blackColor,
                                              value: int.parse(data[index].stateId!),
                                              groupValue: selectedValue,
                                              onChanged: (value) {
                                                selectedValue = value!;
                                                onSelected(data[index].state!);
                                                stateCode(data[index].stateId!);
                                                searchCubit.updateSearchQuery("");
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        );
      },
    );
  }

  static cityListSheetWidget(
      {required BuildContext context,
      required String fieldSelected,
      required CityModal cityModal,
      required Function(String) onSelected,
      required Function(String) cityCode}) {
    showModalBottomSheet<dynamic>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: searchCubit,
          child: DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 0.9,
              minChildSize: 0.2,
              expand: false,
              builder: (context, scrollController) {
                return BlocBuilder<SearchCubit, String>(
                  builder: (context, searchQuery) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: MyText(
                                text: cityModal.responseMsg!,
                                fontSize: 24.h,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: "Search",
                                  prefixIcon: Icon(Icons.search),
                                ),
                                onChanged: (newQuery) {
                                  searchCubit.updateSearchQuery(newQuery);
                                },
                              ),
                            ),
                            SizedBox(height: 10.h),
                            ListView.builder(
                                // primary: false,
                                shrinkWrap: true,
                                // controller: scrollController,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cityModal.responseData?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = cityModal.responseData;
                                  int selectedValue = 0;
                                  if (fieldSelected == data![index].city) {
                                    selectedValue = int.parse(data[index].cityId!);
                                  }
                                  final itemName = "Item ${cityModal.responseData![index].city}";
                                  if (searchQuery.isNotEmpty &&
                                      !itemName.toLowerCase().contains(searchQuery.toLowerCase())) {
                                    return const SizedBox.shrink();
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      cityCode(cityModal.responseData![index].cityId!);
                                      onSelected(cityModal.responseData![index].city!);
                                      searchCubit.updateSearchQuery("");
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      padding: EdgeInsets.only(left: 10.w),
                                      decoration: BoxDecoration(
                                          color: selectedValue == int.parse(data[index].cityId!)
                                              ? MyColor.highLightBlueColor
                                              : MyColor.transparentColor,
                                          borderRadius: BorderRadius.circular(15.r)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 300.w,
                                            child: MyText(
                                              text: cityModal.responseData![index].city.toString(),
                                              textAlign: TextAlign.start,
                                              fontSize: 14.sp,
                                              textOverflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Radio<int>(
                                            activeColor: MyColor.blackColor,
                                            value: int.parse(data[index].cityId!),
                                            groupValue: selectedValue,
                                            onChanged: (value) {
                                              selectedValue = value!;
                                              cityCode(cityModal.responseData![index].cityId!);
                                              onSelected(cityModal.responseData![index].city!);
                                              searchCubit.updateSearchQuery("");
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        );
      },
    );
  }

  static educationBottomSheet({
    required BuildContext context,
    required String fieldSelected,
    required List<Qualification> qualification,
    required Function(String) onSelected,
  }) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w, bottom: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(icon: Icon(Icons.close, size: 30.sp), onPressed: () => Navigator.pop(context)),
                ),
                MyText(
                  text: "Select Your Education",
                  fontSize: 24.h,
                ),
                SizedBox(height: 15.h),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: qualification.length,
                  itemBuilder: (BuildContext context, int index) {
                    int selectedValue = 0;
                    if (fieldSelected == qualification[index].name) {
                      selectedValue = int.parse(qualification[index].id!);
                    }
                    return GestureDetector(
                      onTap: () {
                        onSelected(qualification[index].name!);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10.w),
                        decoration: BoxDecoration(
                          color: selectedValue == int.parse(qualification[index].id!)
                              ? MyColor.highLightBlueColor
                              : MyColor.transparentColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              text: qualification[index].name!,
                              textAlign: TextAlign.center,
                              fontSize: 20.sp,
                            ),
                            Radio<int>(
                              activeColor: MyColor.blackColor,
                              value: int.parse(qualification[index].id!),
                              groupValue: selectedValue,
                              onChanged: (value) {
                                selectedValue = value!;
                                onSelected(qualification[index].name!);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }

  static salaryBottomSheet({
    required BuildContext context,
    required SalaryModal salaryModal,
    required String fieldSelected,
    required Function(String) onSelected,
    required Function(String) salaryCode,
  }) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w, bottom: 25.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(icon: Icon(Icons.close, size: 30.sp), onPressed: () => Navigator.pop(context)),
                  ),
                  MyText(
                    text: "Salary Mode",
                    fontSize: 24.h,
                  ),
                  SizedBox(height: 15.h),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: salaryModal.responseData?.length,
                    itemBuilder: (BuildContext context, int index) {
                      int selectedValue = 0;
                      if (fieldSelected == salaryModal.responseData?[index].name) {
                        selectedValue = int.parse(salaryModal.responseData![index].salaryModeId!);
                      }
                      return GestureDetector(
                        onTap: () {
                          salaryCode(salaryModal.responseData![index].salaryModeId!);
                          onSelected(salaryModal.responseData![index].name!);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 10.w),
                          decoration: BoxDecoration(
                            color: selectedValue == int.parse(salaryModal.responseData![index].salaryModeId!)
                                ? MyColor.highLightBlueColor
                                : MyColor.transparentColor,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: salaryModal.responseData![index].name!,
                                textAlign: TextAlign.center,
                                fontSize: 20.sp,
                              ),
                              Radio<int>(
                                activeColor: MyColor.blackColor,
                                value: int.parse(salaryModal.responseData![index].salaryModeId!),
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  selectedValue = value!;
                                  salaryCode(salaryModal.responseData![index].salaryModeId!);
                                  onSelected(salaryModal.responseData![index].name!);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Emp Type

  static empTypeSheet({
    required String fieldSelected,
    required BuildContext context,
    required EmploymentTypeModal employmentTypeModal,
    required Function(String) onSelected,
    required Function(String) empId,
  }) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(icon: Icon(Icons.close, size: 30.sp), onPressed: () => Navigator.pop(context)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: MyText(
                      text: "Select Employment Type",
                      fontSize: 24.h,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: employmentTypeModal.responseData?.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = employmentTypeModal.responseData;
                      int selectedValue = 0;
                      if (fieldSelected.toLowerCase() == data![index].name?.toLowerCase()) {
                        selectedValue = int.parse(data[index].employmentTypeId!);
                      }
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: GestureDetector(
                            onTap: () {
                              onSelected(employmentTypeModal.responseData![index].name!);
                              empId(employmentTypeModal.responseData![index].employmentTypeId!);

                              Navigator.pop(context);
                            },
                            child: Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                  color: selectedValue == int.parse(data[index].employmentTypeId!)
                                      ? MyColor.highLightBlueColor
                                      : MyColor.transparentColor,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                    text: data[index].name!,
                                    textAlign: TextAlign.start,
                                    fontSize: 20.sp,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                  Radio<int>(
                                    activeColor: MyColor.blackColor,
                                    value: int.parse(data[index].employmentTypeId!),
                                    groupValue: selectedValue,
                                    onChanged: (value) {
                                      selectedValue = value!;
                                      onSelected(employmentTypeModal.responseData![index].name!);
                                      empId(employmentTypeModal.responseData![index].employmentTypeId!);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static commonUserModalBottomSheet({
    required String fieldSelected,
    required BuildContext context,
    required List<dynamic> list,
    required Function(String) onSelected,
    required String heading,
  }) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w, bottom: 25.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.close, size: 30.sp),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                MyText(text: "Select your $heading", fontSize: 24.h),
                SizedBox(height: 15.h),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    int selectedValue = 0;

                    if (fieldSelected.isNotEmpty) {
                      if (fieldSelected.toUpperCase() == list[index].name) {
                        selectedValue = int.parse(list[index].id);
                      }
                    }

                    return GestureDetector(
                      onTap: () {
                        onSelected(list[index].name!);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10.w),
                        decoration: BoxDecoration(
                          color: selectedValue == int.parse(list[index].id)
                              ? MyColor.highLightBlueColor
                              : MyColor.transparentColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(text: list[index].name!, fontSize: 20.sp),
                            Radio<int>(
                              activeColor: MyColor.blackColor,
                              value: int.parse(list[index].id),
                              groupValue: selectedValue,
                              onChanged: (value) {
                                selectedValue = value!;
                                onSelected(list[index].name!);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }

  /// Document Type
  static docTypeModalBottomSheet(
      {required BuildContext context,
      required List<dynamic> list,
      required Function(String) onSelected,
      required Function(String)? onSelectedID,
      required String heading,
      required String fieldSelected}) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w, bottom: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ),
                MyText(
                  text: "Select your $heading",
                  fontSize: 24.h,
                ),
                SizedBox(height: 15.h),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    int selectedValue = 0;
                    if (fieldSelected == list[index].name) {
                      selectedValue = int.parse(list[index].id);
                    }
                    return GestureDetector(
                      onTap: () {
                        onSelected(list[index].name!);
                        onSelectedID!(list[index].id ?? "");
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10.w),
                        decoration: BoxDecoration(
                          color: selectedValue == int.parse(list[index].id)
                              ? MyColor.highLightBlueColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              text: list[index].name!,
                              textAlign: TextAlign.center,
                              fontSize: 20.sp,
                            ),
                            Radio<int>(
                              activeColor: MyColor.blackColor,
                              value: int.parse(list[index].id),
                              groupValue: selectedValue,
                              onChanged: (value) {
                                selectedValue = value!;
                                onSelected(list[index].name!);
                                onSelectedID!(list[index].id ?? "");
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }

  /// Relation Sheet
  static relationModalBottomSheet(
      {required BuildContext context,
      required Function(String) onSelected,
      required String fieldSelected,
      required List<RelationModal> relationList}) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w, bottom: 25.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(icon: Icon(Icons.close, size: 30.sp), onPressed: () => Navigator.pop(context)),
                ),
                MyText(text: "Select your Relation", fontSize: 24.h),
                SizedBox(height: 15.h),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: relationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    int selectedValue = 0;
                    if (fieldSelected.isNotEmpty) {
                      if (fieldSelected == relationList[index].name) {
                        selectedValue = relationList[index].id;
                      }
                    }

                    return GestureDetector(
                      onTap: () {
                        onSelected(relationList[index].name);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10.w),
                        decoration: BoxDecoration(
                          color: selectedValue == relationList[index].id
                              ? MyColor.highLightBlueColor
                              : MyColor.transparentColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              text: relationList[index].name.toUpperCase(),
                              fontSize: 20.sp,
                            ),
                            Radio<int>(
                              activeColor: MyColor.blackColor,
                              value: relationList[index].id,
                              groupValue: selectedValue,
                              onChanged: (value) {
                                selectedValue = value!;
                                onSelected(relationList[index].name);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }

  /// Religion Bottom Sheet
  static religionBottomSheet({
    required String fieldSelected,
    required BuildContext context,
    required ReligionFormModal list,
    required Function(String) onSelected,
    required Function(String) rID,
    required String heading,
  }) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w, bottom: 25.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.close, size: 30.sp),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                MyText(text: "$heading", fontSize: 24.h),
                SizedBox(height: 15.h),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.responseData?.length,
                  itemBuilder: (BuildContext context, int index) {
                    int selectedValue = 0;

                    if (fieldSelected.isNotEmpty) {
                      if (fieldSelected.toUpperCase() == list.responseData![index].name?.toUpperCase()) {
                        selectedValue = int.parse(list.responseData![index].id!);
                      }
                    }

                    return GestureDetector(
                      onTap: () {
                        onSelected(list.responseData![index].name!);
                        rID(list.responseData![index].rId!);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10.w),
                        decoration: BoxDecoration(
                          color: selectedValue == int.parse(list.responseData![index].id!)
                              ? MyColor.highLightBlueColor
                              : MyColor.transparentColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(text: list.responseData![index].name!, fontSize: 20.sp),
                            Radio<int>(
                              activeColor: MyColor.blackColor,
                              value: int.parse(list.responseData![index].id!),
                              groupValue: selectedValue,
                              onChanged: (value) {
                                selectedValue = value!;
                                onSelected(list.responseData![index].name!);
                                rID(list.responseData![index].rId!);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

class RelationModal {
  final int id;
  final String name;

  RelationModal({required this.id, required this.name});

  static final relationList = [
    RelationModal(id: 1, name: 'Parent'),
    RelationModal(id: 2, name: 'Relative'),
    RelationModal(id: 3, name: 'Friend'),
    RelationModal(id: 4, name: 'Spouse'),
    RelationModal(id: 5, name: 'Sibling'),
  ];
}
