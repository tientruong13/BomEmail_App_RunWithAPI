import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum DayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

String dayOfWeekToString(DayOfWeek day) {
  switch (day) {
    case DayOfWeek.Monday:
      return 'mon';
    case DayOfWeek.Tuesday:
      return 'tue';
    case DayOfWeek.Wednesday:
      return 'wed';
    case DayOfWeek.Thursday:
      return 'thu';
    case DayOfWeek.Friday:
      return 'fri';
    case DayOfWeek.Saturday:
      return 'sat';
    case DayOfWeek.Sunday:
      return 'sun';
    default:
      return 'Day ${day.index + 1}';
  }
}

// String dayOfWeekToString(DayOfWeek day) {
//   switch (day) {
//     case DayOfWeek.Monday:
//       return 'monday';
//     case DayOfWeek.Tuesday:
//       return 'tuesday';
//     case DayOfWeek.Wednesday:
//       return 'wednesday';
//     case DayOfWeek.Thursday:
//       return 'thursday';
//     case DayOfWeek.Friday:
//       return 'friday';
//     case DayOfWeek.Saturday:
//       return 'saturday';
//     case DayOfWeek.Sunday:
//       return 'sunday';
//     default:
//       return 'Day ${day.index + 1}';
//   }
// }

DayOfWeek? getDayOfWeek(String dayNow) {
  switch (dayNow.toLowerCase()) {
    case 'monday':
      return DayOfWeek.Monday;
    case 'tuesday':
      return DayOfWeek.Tuesday;
    case 'wednesday':
      return DayOfWeek.Wednesday;
    case 'thursday':
      return DayOfWeek.Thursday;
    case 'friday':
      return DayOfWeek.Friday;
    case 'saturday':
      return DayOfWeek.Saturday;
    case 'sunday':
      return DayOfWeek.Sunday;
    default:
      return null;
  }
}

class WeeklyTime extends StatefulWidget {
  const WeeklyTime({
    Key? key,
    required this.callbackDayOfWeek,
    required this.callbackTimeOfDay,
  }) : super(key: key);
  final void Function(String) callbackDayOfWeek;
  final void Function(TimeOfDay) callbackTimeOfDay;
  @override
  State<WeeklyTime> createState() => _WeeklyTimeState();
}

class _WeeklyTimeState extends State<WeeklyTime> {
  DayOfWeek? eventDay;

  TimeOfDay? eventTime = TimeOfDay.now();

  DayOfWeek _intToDayOfWeek(int dayOfWeekInt) {
    // Be aware that DateTime.weekday returns 1 for Monday and 7 for Sunday
    // So we subtract 1 to match your enum where Monday is 0
    return DayOfWeek.values[dayOfWeekInt - 1];
  }

  String dayNow = DateFormat("EEEE").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    DayOfWeek? dayOfWeekNow = getDayOfWeek(dayNow);
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
                        DayOfWeek.values.indexOf(eventDay ?? dayOfWeekNow!),
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
                                    eventDay = DayOfWeek.values[index];
                                  });
                                  widget.callbackDayOfWeek(
                                      dayOfWeekToString(eventDay!));
                                },
                                children: DayOfWeek.values.map((day) {
                                  return Text(day.toString().split('.').last);
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    eventDay = DayOfWeek
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
                dayOfWeekToString(eventDay ?? dayOfWeekNow!),
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
