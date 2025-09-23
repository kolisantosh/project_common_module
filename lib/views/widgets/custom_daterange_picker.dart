import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// user for DateTime formatting
import 'package:intl/intl.dart';
import 'package:project_common_module/core/utils/src/size_extension.dart';

import 'custom_calender.dart';

class CustomDateRangePicker extends StatefulWidget {
  /// The minimum date that can be selected in the calendar.
  final DateTime minimumDate;

  /// The maximum date that can be selected in the calendar.
  final DateTime maximumDate;

  /// Whether the widget can be dismissed by tapping outside of it.
  final bool barrierDismissible;

  /// The initial start date for the date range picker. If not provided, the calendar will default to the minimum date.
  final DateTime? initialStartDate;

  /// The initial end date for the date range picker. If not provided, the calendar will default to the maximum date.
  final DateTime? initialEndDate;

  /// The primary color used for the date range picker.
  final Color primaryColor;

  /// The background color used for the date range picker.
  final Color backgroundColor;

  /// A callback function that is called when the user applies the selected date range.
  final Function(DateTime, DateTime) onApplyClick;

  /// A callback function that is called when the user cancels the selection of the date range.
  final Function() onCancelClick;

  const CustomDateRangePicker({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    required this.primaryColor,
    required this.backgroundColor,
    required this.onApplyClick,
    this.barrierDismissible = true,
    required this.minimumDate,
    required this.maximumDate,
    required this.onCancelClick,
  });

  @override
  CustomDateRangePickerState createState() => CustomDateRangePickerState();
}

class CustomDateRangePickerState extends State<CustomDateRangePicker> with TickerProviderStateMixin {
  AnimationController? animationController;

  DateTime? startDate;

  DateTime? endDate;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (widget.barrierDismissible) {
              Navigator.pop(context);
            }
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.0.w),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(24.0.w)),
                  boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.withOpacity(0.2), offset: const Offset(4, 4), blurRadius: 8.0.r)],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(24.0.w)),
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'From',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16.sp, color: Colors.grey.shade700),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  startDate != null ? DateFormat('EEE, dd MMM').format(startDate!) : '--/-- ',
                                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                          Container(height: 74.h, width: 1.w, color: Theme.of(context).dividerColor),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'To',
                                  style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16.sp, color: Colors.grey.shade700),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  endDate != null ? DateFormat('EEE, dd MMM').format(endDate!) : '--/-- ',
                                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 1.h),
                      CustomCalendar(
                        minimumDate: widget.minimumDate,
                        maximumDate: widget.maximumDate,
                        initialEndDate: widget.initialEndDate,
                        initialStartDate: widget.initialStartDate,
                        primaryColor: widget.primaryColor,
                        startEndDateChange: (DateTime startDateData, DateTime endDateData) {
                          setState(() {
                            startDate = startDateData;
                            endDate = endDateData;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h, top: 8.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 48.h,
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(24.0.w))),
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    side: WidgetStatePropertyAll(BorderSide(color: widget.primaryColor)),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24.0.w))),
                                    ),
                                    // backgroundColor: MaterialStateProperty.all(widget.primaryColor),
                                  ),
                                  onPressed: () {
                                    try {
                                      widget.onCancelClick();
                                      Navigator.pop(context);
                                    } catch (_) {}
                                  },
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 18.sp, color: widget.primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Container(
                                height: 48.h,
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(24.0.w))),
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    side: WidgetStatePropertyAll(BorderSide(color: widget.primaryColor)),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24.0.w))),
                                    ),
                                    backgroundColor: WidgetStatePropertyAll(widget.primaryColor),
                                  ),
                                  onPressed: () {
                                    try {
                                      widget.onApplyClick(startDate!, endDate!);
                                      Navigator.pop(context);
                                    } catch (_) {}
                                  },
                                  child: Center(
                                    child: Text(
                                      'Apply',
                                      style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showCustomDateRangePicker(
  BuildContext context, {
  required bool dismissible,
  required DateTime minimumDate,
  required DateTime maximumDate,
  DateTime? startDate,
  DateTime? endDate,
  required Function(DateTime startDate, DateTime endDate) onApplyClick,
  required Function() onCancelClick,
  required Color backgroundColor,
  required Color primaryColor,
  String? fontFamily,
}) {
  /// Request focus to take it away from any input field that might be in focus
  FocusScope.of(context).requestFocus(FocusNode());

  /// Show the CustomDateRangePicker dialog box
  showDialog<dynamic>(
    context: context,
    builder:
        (BuildContext context) => CustomDateRangePicker(
          barrierDismissible: true,
          backgroundColor: backgroundColor,
          primaryColor: primaryColor,
          minimumDate: minimumDate,
          maximumDate: maximumDate,
          initialStartDate: startDate,
          initialEndDate: endDate,
          onApplyClick: onApplyClick,
          onCancelClick: onCancelClick,
        ),
  );
}
