import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum DayOfMonth {
  Day1,
  Day2,
  Day3,
  Day4,
  Day5,
  Day6,
  Day7,
  Day8,
  Day9,
  Day10,
  Day11,
  Day12,
  Day13,
  Day14,
  Day15,
  Day16,
  Day17,
  Day18,
  Day19,
  Day20,
  Day21,
  Day22,
  Day23,
  Day24,
  Day25,
  Day26,
  Day27,
  Day28,
  Day29,
  Day30,
  Day31
}

String dayOfMonthToString(DayOfMonth day) {
  switch (day) {
    case DayOfMonth.Day1:
      return 'Once a month on the 1';
    case DayOfMonth.Day2:
      return 'Once a month on the 2';
    case DayOfMonth.Day3:
      return 'Once a month on the 3';
    case DayOfMonth.Day4:
      return 'Once a month on the 4';
    case DayOfMonth.Day5:
      return 'Once a month on the 5';
    case DayOfMonth.Day6:
      return 'Once a month on the 6';
    case DayOfMonth.Day7:
      return 'Once a month on the 7';
    case DayOfMonth.Day8:
      return 'Once a month on the 8';
    case DayOfMonth.Day9:
      return 'Once a month on the 9';
    case DayOfMonth.Day10:
      return 'Once a month on the 10';
    case DayOfMonth.Day11:
      return 'Once a month on the 11';
    case DayOfMonth.Day12:
      return 'Once a month on the 12';
    case DayOfMonth.Day13:
      return 'Once a month on the 13';
    case DayOfMonth.Day14:
      return 'Once a month on the 14';
    case DayOfMonth.Day15:
      return 'Once a month on the 15';
    case DayOfMonth.Day16:
      return 'Once a month on the 16';
    case DayOfMonth.Day17:
      return 'Once a month on the 17';
    case DayOfMonth.Day18:
      return 'Once a month on the 18';
    case DayOfMonth.Day19:
      return 'Once a month on the 19';
    case DayOfMonth.Day20:
      return 'Once a month on the 20';
    case DayOfMonth.Day21:
      return 'Once a month on the 21';
    case DayOfMonth.Day22:
      return 'Once a month on the 22';
    case DayOfMonth.Day23:
      return 'Once a month on the 23';
    case DayOfMonth.Day24:
      return 'Once a month on the 24';
    case DayOfMonth.Day25:
      return 'Once a month on the 25';
    case DayOfMonth.Day26:
      return 'Once a month on the 26';
    case DayOfMonth.Day27:
      return 'Once a month on the 27';
    case DayOfMonth.Day28:
      return 'Once a month on the 28';
    case DayOfMonth.Day29:
      return 'Once a month on the 29';
    case DayOfMonth.Day30:
      return 'Once a month on the 30';
    case DayOfMonth.Day31:
      return 'Once a month on the 31';
    default:
      return 'Day ${day.index + 1}';
  }
}

class MonthlyTime extends StatefulWidget {
  const MonthlyTime({
    Key? key,
    required this.callbackDayOfMonth,
    required this.callbackTimeOfDay,
  }) : super(key: key);
  final void Function(int) callbackDayOfMonth;
  final void Function(TimeOfDay) callbackTimeOfDay;
  @override
  State<MonthlyTime> createState() => _MonthlyTimeState();
}

class _MonthlyTimeState extends State<MonthlyTime> {
  int currentDay = DateTime.now().day;
  DayOfMonth? selectedDay;

  TimeOfDay? eventTime = TimeOfDay.now();

  DayOfMonth _intToDayOfMonth(int dayOfMonthInt) {
    return DayOfMonth.values[dayOfMonthInt - 1];
  }

  @override
  Widget build(BuildContext context) {
    DayOfMonth todayEnum = _intToDayOfMonth(currentDay);
    return SizedBox(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  FixedExtentScrollController scrollController =
                      FixedExtentScrollController(
                    initialItem:
                        DayOfMonth.values.indexOf(selectedDay ?? todayEnum),
                  );
                  return Container(
                    width: 100.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                        // borderRadius: BorderRadius.vertical(
                        //   top: Radius.elliptical(200, 70),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Column(
                          children: [
                            Expanded(
                              child: CupertinoPicker(
                                scrollController: scrollController,
                                diameterRatio: 1.1,
                                itemExtent: 32.0,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    selectedDay = DayOfMonth.values[index];
                                  });
                                  widget.callbackDayOfMonth(index + 1);
                                },
                                children: DayOfMonth.values.map((day) {
                                  return Text(dayOfMonthToString(day));
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedDay = DayOfMonth
                                        .values[scrollController.selectedItem];
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              width: 100.w,
              height: 5.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade500.withOpacity(0.2),
              ),
              padding: EdgeInsets.all(3.w),
              child: Text(
                dayOfMonthToString(selectedDay ?? todayEnum),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.w,
          ),
          GestureDetector(
            onTap: () async {
              DateTime now = DateTime.now();
              if (eventTime == null) {
                DateTime initialTime = now.add(Duration(minutes: 1));
                eventTime = TimeOfDay.fromDateTime(initialTime);
              } else {
                DateTime initialTime = DateTime(now.year, now.month, now.day,
                    eventTime!.hour, eventTime!.minute);
                eventTime = TimeOfDay.fromDateTime(initialTime);
              }
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    width: 100.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                        // borderRadius: BorderRadius.vertical(
                        //   top: Radius.elliptical(200, 70),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Expanded(
                            child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.time,
                                initialDateTime: DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                  eventTime!.hour,
                                  eventTime!.minute,
                                ),
                                onDateTimeChanged: (val) {
                                  eventTime = TimeOfDay.fromDateTime(val);
                                  widget.callbackTimeOfDay(
                                      TimeOfDay.fromDateTime(val));
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              width: 100.w,
              height: 5.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade500.withOpacity(0.2),
              ),
              padding: EdgeInsets.all(3.w),
              child: Text(
                eventTime == null
                    ? "Select Your Time"
                    : MaterialLocalizations.of(context).formatTimeOfDay(
                        eventTime!,
                        alwaysUse24HourFormat: true),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
