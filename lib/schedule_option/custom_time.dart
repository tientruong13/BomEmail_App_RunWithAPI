import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTime extends StatefulWidget {
  const CustomTime({
    Key? key,
    required this.callbackDayCustom,
    required this.callbackTimeCustom,
  }) : super(key: key);
  final void Function(DateTime) callbackDayCustom;
  final void Function(TimeOfDay) callbackTimeCustom;
  @override
  State<CustomTime> createState() => _CustomTimeState();
}

class _CustomTimeState extends State<CustomTime> {
  DateTime eventDate = DateTime.now();

  TimeOfDay eventTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  final today = DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day);
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
                              child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  minimumDate: today,
                                  maximumDate: DateTime(today.year + 10),
                                  initialDateTime: eventDate,
                                  onDateTimeChanged: (val) {
                                    eventDate =
                                        DateTime(val.year, val.month, val.day);
                                    widget.callbackDayCustom(
                                        DateTime(val.year, val.month, val.day));
                                  }),
                            ),
                            TextButton(
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
                DateFormat("yyyy-MM-dd").format(eventDate),
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
              final now = DateTime.now();

              DateTime initialDateTime = DateTime(
                eventDate.year,
                eventDate.month,
                eventDate.day,
                eventTime.hour,
                eventTime.minute,
              );

              if (eventDate.year == now.year &&
                  eventDate.month == now.month &&
                  eventDate.day == now.day &&
                  (eventTime.hour < now.hour ||
                      (eventTime.hour == now.hour &&
                          eventTime.minute <= now.minute))) {
                initialDateTime = now;
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
                                use24hFormat: true,
                                initialDateTime: initialDateTime,
                                onDateTimeChanged: (val) {
                                  if (val.isBefore(now)) {
                                    val = now;
                                  }
                                  setState(() {
                                    eventTime = TimeOfDay(
                                        hour: val.hour, minute: val.minute);
                                  });
                                  widget.callbackTimeCustom(
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
                MaterialLocalizations.of(context)
                    .formatTimeOfDay(eventTime, alwaysUse24HourFormat: true),
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
