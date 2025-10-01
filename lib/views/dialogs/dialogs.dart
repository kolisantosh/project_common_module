import 'package:flutter/material.dart';
import 'package:project_common_module/views.dart';

/*showReportFilterDialog(context) {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  // ReportCubit reportCubit = GetIt.I<ReportCubit>();
  // ProfileCubit profileCubit = GetIt.I<ProfileCubit>();
  // DateTime? startDate = reportCubit.selectedDate.isNotEmpty ? DateTime.parse(reportCubit.selectedDate.split(" to ")[0]) : DateTime.now();
  // DateTime? endDate = reportCubit.selectedDate.isNotEmpty ? DateTime.parse(reportCubit.selectedDate.split(" to ")[1]) : DateTime.now();
  return showModalBottomSheet(
      backgroundColor: Colors.white,
      elevation: 0,
      context: context,
      isDismissible: false,
      isScrollControlled: false,
      scrollControlDisabledMaxHeightRatio: 0.95,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(35.0.w), topRight: Radius.circular(35.0.w)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return BlocBuilder<ReportCubit, ReportState>(
              bloc: reportCubit,
              builder: (_, state) {
                bool isAnyFilterFilled(ReportCubit controller) {
                  return reportCubit.selectedDate.isNotEmpty ||
                      controller.dropDownFloor != null ||
                      controller.dropDownRoom != null ||
                      controller.dropDownBed != null ||
                      controller.dropDownNurse != null ||
                      controller.dropDownShift != null;
                }

                List<AssignedNS> _getUniqueFloors(List<AssignedNS> list) {
                  final seen = <int>{};
                  return list.where((e) => e.floorId != null && seen.add(e.floorId!)).toList();
                }

                List<AssignedNS> _getFilterNS(List<AssignedNS> list) {
                  return list.where((e) => e.floorId != null && e.floorId == reportCubit.dropDownFloor?.floorId).toList();
                }

                if (reportCubit.selectedDate.isNotEmpty) {
                  nameController.text = reportCubit.selectedDate;
                }

                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(18.w, 30.h, 18.w, MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.filters,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    color: AppColors.textColor, fontFamily: "DMSans-Bold", fontWeight: FontWeight.w900, fontSize: 32.sp),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(color: AppColors.backgroundColor1, shape: BoxShape.circle),
                                  padding: EdgeInsets.all(12.w),
                                  height: 41,
                                  child: SvgPicture.asset(
                                    ImagePath.icClose,
                                    colorFilter: const ColorFilter.mode(AppColors.backgroundColor, BlendMode.srcIn),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            GestureDetector(
                              onTap: () {
                                showCustomDateRangePicker(
                                  context,
                                  dismissible: true,
                                  minimumDate: DateTime.now().subtract(const Duration(days: 365)),
                                  maximumDate: DateTime.now(),
                                  endDate: endDate,
                                  startDate: startDate,
                                  backgroundColor: Colors.white,
                                  primaryColor: AppColors.primaryColor,
                                  onApplyClick: (start, end) {
                                    setState(() {
                                      endDate = end;
                                      startDate = start;
                                      nameController.text =
                                          "${startDate != null ? DateFormat("yyyy-MM-dd").format(startDate!) : 'YY-MM-DD'} to ${endDate != null ? DateFormat("yyyy-MM-dd").format(endDate!) : 'YY-MM-DD'}";
                                      reportCubit.selectedDate = nameController.text;
                                    });
                                  },
                                  onCancelClick: () {
                                    setState(() {
                                      nameController.text =
                                          "${startDate != null ? DateFormat("yyyy-MM-dd").format(startDate!) : 'YY-MM-DD'} to ${endDate != null ? DateFormat("yyyy-MM-dd").format(endDate!) : 'YY-MM-DD'}";
                                      reportCubit.selectedDate = nameController.text;
                                    });
                                  },
                                );
                              },
                              child: CommonHeaderTextField(
                                      headerText: Strings.selectDate,
                                      hintText: "YY-MM-DD to YY-MM-DD",
                                      validator: (str) {
                                        return null;
                                      },
                                      enabled: false,
                                      onTap: () {
                                        showReportFilterDialog(context);
                                      },
                                      suffix: Padding(
                                        padding: EdgeInsets.all(15.0.w),
                                        child: GestureDetector(
                                            child: SvgPicture.asset(
                                          ImagePath.icDate,
                                        )),
                                      ),
                                      controller: nameController)
                                  .paddingSymmetric(vertical: 15.h),
                            ),
                            CommonHeaderDropDownTextField1(
                              items: _getUniqueFloors(profileCubit.userData!.assignedNS!)
                                  .map((label) => DropdownMenuItem(
                                        value: label,
                                        child: Text(label.floorName!.capitalize.toString()),
                                      ))
                                  .toList(),
                              // selectedValue: controller.dropDownBank.isEmpty ? null : controller.dropDownBank,
                              headerText: Strings.floor,
                              onChanged: (value) {
                                reportCubit.dropDownFloor = value;
                                if (reportCubit.dropDownFloor != null && reportCubit.dropDownNurse != null) {
                                  reportCubit.dropDownRoom = null;
                                  reportCubit.dropDownBed = null;
                                  reportCubit.fetchRoom();
                                }
                              },
                              autoValidationMode: AutovalidateMode.onUserInteraction,
                              suffix: SvgPicture.asset(
                                ImagePath.icArrowDown,
                              ),
                              initialValue: _getUniqueFloors(profileCubit.userData!.assignedNS!).contains(reportCubit.dropDownFloor)
                                  ? reportCubit.dropDownFloor
                                  : null,
                              hintText: reportCubit.dropDownFloor == null
                                  ? Strings.selectFloor
                                  : reportCubit.dropDownFloor!.floorName!.capitalize!,
                              // validator: (value) {
                              //   return value != null || reportCubit.dropDownFloor == null ? null : "Please ${Strings.selectFloor}";
                              // },
                            ),
                            CommonHeaderDropDownTextField1(
                              items: _getFilterNS(profileCubit.userData!.assignedNS!)
                                  .map((label) => DropdownMenuItem(
                                        value: label,
                                        child: Text(label.nSName!.capitalize.toString()),
                                      ))
                                  .toList(),
                              // selectedValue: controller.dropDownBank.isEmpty ? null : controller.dropDownBank,
                              headerText: Strings.nurseStation,
                              onChanged: (value) {
                                reportCubit.dropDownNurse = value;
                                if (reportCubit.dropDownFloor != null && reportCubit.dropDownNurse != null) {
                                  reportCubit.dropDownRoom = null;
                                  reportCubit.dropDownBed = null;
                                  reportCubit.fetchRoom();
                                }
                              },
                              autoValidationMode: AutovalidateMode.onUserInteraction,
                              suffix: SvgPicture.asset(
                                ImagePath.icArrowDown,
                              ),
                              initialValue: _getFilterNS(profileCubit.userData!.assignedNS!).contains(reportCubit.dropDownNurse)
                                  ? reportCubit.dropDownNurse
                                  : null,
                              hintText: reportCubit.dropDownNurse == null
                                  ? Strings.selectNurseStation
                                  : reportCubit.dropDownNurse!.nSName!.capitalize!,
                              // validator: (value) {
                              //   return value != null || reportCubit.dropDownNurse == null ? null : "Please ${Strings.selectNurseStation}";
                              // },
                            ).paddingSymmetric(vertical: 15.h),
                            reportCubit.roomModel != null && reportCubit.roomModel!.data!.isNotEmpty
                                ? CommonHeaderDropDownTextField1(
                                    items: reportCubit.roomModel!.data!
                                        .map((label) => DropdownMenuItem(
                                              value: label,
                                              child: Text(label.roomAlias!.capitalize.toString()),
                                            ))
                                        .toList(),
                                    // selectedValue: controller.dropDownBank.isEmpty ? null : controller.dropDownBank,
                                    headerText: Strings.room,
                                    onChanged: (value) {
                                      reportCubit.dropDownRoom = value;
                                      if (reportCubit.dropDownFloor != null &&
                                          reportCubit.dropDownNurse != null &&
                                          reportCubit.dropDownRoom != null) {
                                        reportCubit.dropDownBed = null;
                                        reportCubit.fetchBed();
                                      }
                                    },
                                    autoValidationMode: AutovalidateMode.onUserInteraction,
                                    suffix: SvgPicture.asset(
                                      ImagePath.icArrowDown,
                                    ),
                                    initialValue:
                                        reportCubit.roomModel!.data!.contains(reportCubit.dropDownRoom) ? reportCubit.dropDownRoom : null,
                                    hintText: reportCubit.dropDownRoom == null
                                        ? Strings.selectRoom
                                        : reportCubit.dropDownRoom!.roomAlias!.capitalize!,
                                    // validator: (value) {
                                    //   return value != null || reportCubit.dropDownRoom == null ? null : "Please ${Strings.selectRoom}";
                                    // },
                                  )
                                : Container(),
                            reportCubit.bedModel != null && reportCubit.bedModel!.data!.isNotEmpty
                                ? CommonHeaderDropDownTextField1(
                                    items: reportCubit.bedModel!.data!
                                        .map((label) => DropdownMenuItem(
                                              value: label,
                                              child: Text(label.bedAlias!.capitalize.toString()),
                                            ))
                                        .toList(),
                                    // selectedValue: controller.dropDownBank.isEmpty ? null : controller.dropDownBank,
                                    headerText: Strings.bedNo,
                                    onChanged: (value) {
                                      reportCubit.dropDownBed = value;
                                    },
                                    autoValidationMode: AutovalidateMode.onUserInteraction,
                                    suffix: SvgPicture.asset(
                                      ImagePath.icArrowDown,
                                    ),
                                    initialValue:
                                        reportCubit.bedModel!.data!.contains(reportCubit.dropDownBed) ? reportCubit.dropDownBed : null,
                                    hintText: reportCubit.dropDownBed == null
                                        ? Strings.selectBed
                                        : reportCubit.dropDownBed!.bedAlias!.capitalize!,
                                    // validator: (value) {
                                    //   return value != null || reportCubit.dropDownBed == null ? null : "Please ${Strings.selectBed}";
                                    // },
                                  ).paddingSymmetric(vertical: 15.h)
                                : Container().paddingSymmetric(vertical: 10.h),
                            CommonHeaderDropDownTextField1(
                              items: profileCubit.userData!.assignedShifts!
                                  .map((label) => DropdownMenuItem(
                                        value: label,
                                        child: Text(label.shiftName!.capitalize.toString()),
                                      ))
                                  .toList(),
                              // selectedValue: controller.dropDownBank.isEmpty ? null : controller.dropDownBank,
                              headerText: Strings.shift,
                              onChanged: (value) {
                                reportCubit.dropDownShift = value;
                              },
                              autoValidationMode: AutovalidateMode.onUserInteraction,
                              suffix: SvgPicture.asset(
                                ImagePath.icArrowDown,
                              ),
                              hintText: reportCubit.dropDownShift == null
                                  ? Strings.selectShift
                                  : reportCubit.dropDownShift!.shiftName!.capitalize!,
                              // validator: (value) {
                              //   return value != null || reportCubit.dropDownShift == null ? null : "Please ${Strings.selectShift}";
                              // },
                            ),
                            CommonIconButton(
                                    onTap: () {
                                      setState(() {
                                        endDate = null;
                                        startDate = null;
                                      });
                                      reportCubit.dropDownFloor = null;
                                      reportCubit.dropDownRoom = null;
                                      reportCubit.dropDownBed = null;
                                      reportCubit.dropDownNurse = null;
                                      reportCubit.dropDownShift = null;
                                      reportCubit.isFilter = false;
                                      reportCubit.filterData = null;
                                      reportCubit.page = 1;
                                      reportCubit.reportModel = null;
                                      reportCubit.selectedDate = "";
                                      reportCubit.fetchReports();
                                      nameController.clear();
                                      Navigator.pop(context);
                                    },
                                    color: AppColors.alertColor,
                                    style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 18.sp, color: Colors.white),
                                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                                    margin: EdgeInsets.zero,
                                    widthFull: false,
                                    title: Strings.resetFilters,
                                    imagePath: "")
                                .paddingSymmetric(vertical: 30.h),
                          ]))),
                          CommonIconButton(
                                  onTap: () async {
                                    if (isAnyFilterFilled(reportCubit)) {
                                      reportCubit.isFilter = true;
                                      reportCubit.page = 1;
                                      reportCubit.reportModel = null;
                                      reportCubit.filterData = {
                                        "fromDate": reportCubit.selectedDate.isEmpty ? '' : reportCubit.selectedDate.split(" to ")[0],
                                        "toDate": reportCubit.selectedDate.isEmpty ? '' : reportCubit.selectedDate.split(" to ")[1],
                                        "floorId": reportCubit.dropDownFloor?.floorId,
                                        "NSNumber": reportCubit.dropDownNurse?.nSNumber,
                                        "roomId": reportCubit.dropDownRoom?.roomId,
                                        "bedNumber": reportCubit.dropDownBed?.bedNumber,
                                        "shiftId": reportCubit.dropDownShift?.shiftId,
                                      };
                                      reportCubit.fetchReports();
                                      Navigator.pop(context);
                                    } else {
                                      showSnackBarTop(context, "filled at least one filter to proceed", error: true);
                                    }
                                  },
                                  color: AppColors.primaryColor,
                                  style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 20.sp, color: Colors.white),
                                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.h),
                                  margin: EdgeInsets.zero,
                                  title: Strings.apply,
                                  imagePath: "")
                              .paddingSymmetric(vertical: 20.h),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
      });
}*/
class CommonDialog {
  static showCommonDialog(context, child, {scrollControlDisabledMaxHeightRatio = 9.0 / 16.0}) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      elevation: 0,
      context: context,
      constraints: BoxConstraints.expand(),
      isDismissible: false,
      useSafeArea: true,
      scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(100.0.w), topRight: Radius.circular(100.0.w))),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(0.w, 60.h, 0.w, 0.h), //MediaQuery.of(context).viewInsets.bottom
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(100.0.w), topRight: Radius.circular(100.0.w)),
            child: child,
          ),
        );
      },
    );
  }
}
