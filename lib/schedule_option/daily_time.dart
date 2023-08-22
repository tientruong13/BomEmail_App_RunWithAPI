import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class DailyTime extends StatefulWidget {
  const DailyTime({
    Key? key,
    required this.callback,
  }) : super(key: key);
  final void Function(TimeOfDay) callback;
  @override
  State<DailyTime> createState() => _DailyTimeState();
}

class _DailyTimeState extends State<DailyTime> {
  DateTime? eventDate = DateTime.now();
  TimeOfDay? eventTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    print(eventTime);
    return SizedBox(
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 5.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade500.withOpacity(0.2),
            ),
            padding: EdgeInsets.all(3.w),
            child: Text(
              'Every Day',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 3.w,
          ),
          GestureDetector(
            onTap: () async {
              DateTime now = DateTime.now();
              // If eventTime has never been set, initialize it to current time + 1 minute
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
                                  widget.callback(TimeOfDay.fromDateTime(val));
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
              width: double.infinity,
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
