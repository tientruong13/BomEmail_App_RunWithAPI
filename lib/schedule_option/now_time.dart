import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NowTime extends StatefulWidget {
  const NowTime({
    Key? key,
  }) : super(key: key);

  @override
  State<NowTime> createState() => _NowTimeState();
}

class _NowTimeState extends State<NowTime> {
  DateTime eventDate = DateTime.now();

  TimeOfDay eventTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
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
              DateFormat("yyyy-MM-dd").format(eventDate),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 3.w,
          ),
          Container(
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
        ],
      ),
    );
  }
}
