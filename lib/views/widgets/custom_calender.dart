import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// user for DateTime formatting
import 'package:intl/intl.dart';
import 'package:project_common_module/core/utils/src/size_extension.dart';

import '../../core/utils/src/screen_util.dart';

class CustomCalendar extends StatefulWidget {
  /// The minimum date that can be selected on the calendar
  final DateTime? minimumDate;

  /// The maximum date that can be selected on the calendar
  final DateTime? maximumDate;

  /// The initial start date to be shown on the calendar
  final DateTime? initialStartDate;

  /// The initial end date to be shown on the calendar
  final DateTime? initialEndDate;

  /// The primary color to be used in the calendar's color scheme
  final Color primaryColor;

  /// A function to be called when the selected date range changes
  final Function(DateTime, DateTime)? startEndDateChange;

  const CustomCalendar({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    this.startEndDateChange,
    this.minimumDate,
    this.maximumDate,
    required this.primaryColor,
  });

  @override
  CustomCalendarState createState() => CustomCalendarState();
}

class CustomCalendarState extends State<CustomCalendar> {
  List<DateTime> dateList = <DateTime>[];

  DateTime currentMonthDate = DateTime.now();

  DateTime? startDate;

  DateTime? endDate;

  @override
  void initState() {
    setListOfDate(currentMonthDate);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setListOfDate(DateTime monthDate) {
    dateList.clear();
    final DateTime newDate = DateTime(monthDate.year, monthDate.month, 0);
    int previousMothDay = 0;
    if (newDate.weekday < 7) {
      previousMothDay = newDate.weekday;
      for (int i = 1; i <= previousMothDay; i++) {
        dateList.add(newDate.subtract(Duration(days: previousMothDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousMothDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, top: 4.h, bottom: 4.h),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Container(
                  height: 38.w,
                  width: 38.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24.0.w)),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(24.0.w)),
                      onTap: () {
                        setState(() {
                          currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month, 0);
                          setListOfDate(currentMonthDate);
                        });
                      },
                      child: const Icon(Icons.keyboard_arrow_left, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    DateFormat('MMMM, yyyy').format(currentMonthDate),
                    style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.grey.shade700),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Container(
                  height: 38.w,
                  width: 38.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24.0.w)),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(24.0.w)),
                      onTap: () {
                        setState(() {
                          currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month + 2, 0);
                          setListOfDate(currentMonthDate);
                        });
                      },
                      child: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(right: 8.w, left: 8.w, bottom: 8.h), child: Row(children: getDaysNameUI())),
        Padding(padding: EdgeInsets.only(right: 8.w, left: 8.w), child: Column(children: getDaysNoUI())),
      ],
    );
  }

  List<Widget> getDaysNameUI() {
    final List<Widget> listUI = <Widget>[];
    for (int i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              DateFormat('EEE').format(dateList[i]),
              style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w500, color: widget.primaryColor),
            ),
          ),
        ),
      );
    }
    return listUI;
  }

  List<Widget> getDaysNoUI() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    for (int i = 0; i < dateList.length / 7; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < 7; i++) {
        final DateTime date = dateList[count];
        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 2.h,
                          bottom: 2.h,
                          left: isStartDateRadius(date) ? 4.w : 0,
                          right: isEndDateRadius(date) ? 4.w : 0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                startDate != null && endDate != null
                                    ? getIsItStartAndEndDate(date) || getIsInRange(date)
                                        ? widget.primaryColor.withOpacity(0.4)
                                        : Colors.transparent
                                    : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: isStartDateRadius(date) ? Radius.circular(24.0.w) : const Radius.circular(0.0),
                              topLeft: isStartDateRadius(date) ? Radius.circular(24.0.w) : const Radius.circular(0.0),
                              topRight: isEndDateRadius(date) ? Radius.circular(24.0.w) : const Radius.circular(0.0),
                              bottomRight: isEndDateRadius(date) ? Radius.circular(24.0.w) : const Radius.circular(0.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(32.0.w)),
                      onTap: () {
                        if (currentMonthDate.month <= date.month || currentMonthDate.month >= date.month) {
                          if (widget.minimumDate != null && widget.maximumDate != null) {
                            final DateTime minimumDate = DateTime(
                              widget.minimumDate!.year,
                              widget.minimumDate!.month,
                              widget.minimumDate!.day - 1,
                            );
                            final DateTime maximumDate = DateTime(
                              widget.maximumDate!.year,
                              widget.maximumDate!.month,
                              widget.maximumDate!.day + 1,
                            );
                            if (date.isAfter(minimumDate) && date.isBefore(maximumDate)) {
                              onDateClick(date);
                            }
                          } else if (widget.minimumDate != null) {
                            final DateTime minimumDate = DateTime(
                              widget.minimumDate!.year,
                              widget.minimumDate!.month,
                              widget.minimumDate!.day - 1,
                            );
                            if (date.isAfter(minimumDate)) {
                              onDateClick(date);
                            }
                          } else if (widget.maximumDate != null) {
                            final DateTime maximumDate = DateTime(
                              widget.maximumDate!.year,
                              widget.maximumDate!.month,
                              widget.maximumDate!.day + 1,
                            );
                            if (date.isBefore(maximumDate)) {
                              onDateClick(date);
                            }
                          } else {
                            onDateClick(date);
                          }
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: getIsItStartAndEndDate(date) ? widget.primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(32.0.w)),
                            border: Border.all(color: getIsItStartAndEndDate(date) ? Colors.white : Colors.transparent, width: 2.w),
                            boxShadow:
                                getIsItStartAndEndDate(date)
                                    ? <BoxShadow>[
                                      BoxShadow(color: Colors.grey.withOpacity(0.6), blurRadius: 4.r, offset: const Offset(0, 0)),
                                    ]
                                    : null,
                          ),
                          child: Center(
                            child: Text(
                              '${date.day}',
                              style: GoogleFonts.inter(
                                color:
                                    getIsItStartAndEndDate(date)
                                        ? Colors.white
                                        : (date.isAfter(widget.minimumDate!) && date.isBefore(widget.maximumDate!))
                                        // : currentMonthDate.month >= date.month && DateTime.now().isAfter(date)
                                        // : (currentMonthDate.month <= date.month || currentMonthDate.month >= date.month)
                                        ? widget.primaryColor
                                        : Colors.grey.withOpacity(0.6),
                                fontSize: ScreenUtil().screenWidth > 360 ? 18.sp : 16.sp,
                                fontWeight: getIsItStartAndEndDate(date) ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 9,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color:
                            DateTime.now().day == date.day && DateTime.now().month == date.month && DateTime.now().year == date.year
                                ? getIsInRange(date)
                                    ? Colors.white
                                    : widget.primaryColor
                                : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        count += 1;
      }
      noList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: listUI,
        ),
      );
    }
    return noList;
  }

  bool getIsInRange(DateTime date) {
    if (startDate != null && endDate != null) {
      if (date.isAfter(startDate!) && date.isBefore(endDate!)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool getIsItStartAndEndDate(DateTime date) {
    if (startDate != null && startDate!.day == date.day && startDate!.month == date.month && startDate!.year == date.year) {
      return true;
    } else if (endDate != null && endDate!.day == date.day && endDate!.month == date.month && endDate!.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  bool isStartDateRadius(DateTime date) {
    if (startDate != null && startDate!.day == date.day && startDate!.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isEndDateRadius(DateTime date) {
    if (endDate != null && endDate!.day == date.day && endDate!.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  void onDateClick(DateTime date) {
    // New selection if nothing selected or both dates already set
    if (startDate == null || (startDate != null && endDate != null)) {
      startDate = date;
      endDate = null;
    } else if (startDate != null && endDate == null) {
      // Second tap: either deselect or form a range
      if (date.year == startDate!.year && date.month == startDate!.month && date.day == startDate!.day) {
        // Same date tapped: clear
        startDate = null;
      } else {
        endDate = date;
        // Ensure startDate <= endDate
        if (!endDate!.isAfter(startDate!)) {
          final temp = startDate;
          startDate = endDate;
          endDate = temp;
        }
      }
    }

    // Normalize: if only one date is selected, treat it as both for callback
    final callbackStart = startDate;
    final callbackEnd = endDate ?? startDate;

    setState(() {
      try {
        if (callbackStart != null && callbackEnd != null) {
          widget.startEndDateChange!(callbackStart, callbackEnd);
        }
      } catch (_) {}
    });
  }
}
