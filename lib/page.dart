import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_email/attachments_grid%20.dart';
import 'package:send_email/homepage.dart';
import 'package:send_email/provider.dart';
import 'package:send_email/schedule_option/custom_time.dart';
import 'package:send_email/schedule_option/daily_time.dart';
import 'package:send_email/schedule_option/monthly_time.dart';
import 'package:send_email/schedule_option/now_time.dart';
import 'package:send_email/schedule_option/weekly_time.dart';
import 'package:send_email/send_email_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageTest extends StatefulWidget {
  PageTest({super.key});

  @override
  State<PageTest> createState() => _PageTestState();
}

class _PageTestState extends State<PageTest> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailFromController = TextEditingController();

  TextEditingController passWordController = TextEditingController();

  TextEditingController emailToController = TextEditingController();

  TextEditingController subjectController = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  TextEditingController quantityController = TextEditingController();

  bool _showPassword = false;

  String _sendType = 'single';

  final _emailList = <String>[];

  int _selectedIndex = 0;

  List<String> attachmentsList = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  DateTime? selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  String? selectedDayOfWeek;
  int? day;
  String formatTimeOfDayTo24Hour(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    final sendEmailProvider = Provider.of<SendEmailProvider>(context);
    String getScheduleOption(int _selectedIndex) {
      if (_selectedIndex == 0) {
        return "now";
      } else if (_selectedIndex == 1) {
        return "daily";
      } else if (_selectedIndex == 2) {
        return "weekly";
      } else if (_selectedIndex == 3) {
        return "monthly";
      } else {
        return "custom";
      }
    }

    showImagePicker() async {
      List<String> filePaths = await sendEmailProvider.pickFiles();

      if (filePaths.isNotEmpty) {
        attachmentsList.addAll(filePaths);
        setState(() {});
      }
    }

    String formattedSelectedTime =
        formatTimeOfDayTo24Hour(selectedTime ?? TimeOfDay.now());
    print('get Time $formattedSelectedTime');
    print('get DayCustom ${selectedDate?.toIso8601String().split('T').first}');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Send Email',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          elevation: 6,
          centerTitle: true,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => BookmarkScreen()),
                // );
              },
              icon: Icon(Icons.bookmark, color: Colors.white),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFirldWidget(
                      controller: nameController,
                      text: 'Name',
                      icon: Icons.person,
                    ),
                    TextFirldWidget(
                      controller: emailFromController,
                      keyboardType: TextInputType.emailAddress,
                      text: 'Your Email',
                      icon: Icons.email,
                    ),
                    TextFirldWidget(
                      controller: passWordController,
                      text: 'Your Password',
                      obscureText: !this._showPassword,
                      icon: Icons.password,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: this._showPassword ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () {
                          setState(
                              () => this._showPassword = !this._showPassword);
                        },
                      ),
                    ),
                    TextFirldWidget(
                      controller: emailToController,
                      keyboardType: TextInputType.emailAddress,
                      text: 'Email To:',
                      icon: Icons.email,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text(
                                "single",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Radio<String>(
                                value: 'single',
                                groupValue: _sendType,
                                onChanged: (String? value) {
                                  setState(() {
                                    _sendType = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "multiple",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Radio<String>(
                                value: 'multiple',
                                groupValue: _sendType,
                                onChanged: (String? value) {
                                  setState(() {
                                    _sendType = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextFirldWidget(
                      controller: subjectController,
                      text: 'Subject',
                      icon: Icons.subject,
                    ),
                    TextFirldWidget(
                      maxLines: 5,
                      controller: bodyController,
                      text: 'Body',
                      icon: Icons.subject,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFirldWidget(
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            text: 'Quantity',
                            icon: Icons.numbers,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showImagePicker();
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Icon(Icons.attach_file),
                          ),
                        ),
                      ],
                    ),
                    attachmentsList.isNotEmpty
                        ? AttachmentsGrid(
                            attachmentsList: attachmentsList,
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            _onItemTapped(0);
                          },
                          child: Text(
                            "Now",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: _selectedIndex == 0
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _onItemTapped(1);
                          },
                          child: Text(
                            "Daily",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: _selectedIndex == 1
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _onItemTapped(2);
                          },
                          child: Text(
                            "Weekly",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: _selectedIndex == 2
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _onItemTapped(3);
                          },
                          child: Text(
                            "Monthly",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: _selectedIndex == 3
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              _onItemTapped(4);
                            },
                            child: Text(
                              "Custom",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: _selectedIndex == 4
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ))
                      ],
                    ),
                    if (_selectedIndex == 0) NowTime(),
                    if (_selectedIndex == 1)
                      DailyTime(
                        callback: (val) {
                          setState(() {
                            selectedTime = val;
                          });
                        },
                      ),
                    if (_selectedIndex == 2)
                      WeeklyTime(
                        callbackDayOfWeek: (val) {
                          setState(() {
                            selectedDayOfWeek = val;
                          });
                        },
                        callbackTimeOfDay: (val) {
                          setState(() {
                            selectedTime = val;
                          });
                        },
                      ),
                    if (_selectedIndex == 3)
                      MonthlyTime(
                        callbackDayOfMonth: (val) {
                          setState(() {
                            day = val;
                          });
                        },
                        callbackTimeOfDay: (val) {
                          setState(() {
                            selectedTime = val;
                          });
                        },
                      ),
                    if (_selectedIndex == 4)
                      CustomTime(
                        callbackDayCustom: (val) {
                          setState(() {
                            selectedDate = val;
                          });
                        },
                        callbackTimeCustom: (val) {
                          setState(() {
                            selectedTime = val;
                          });
                        },
                      ),
                    ElevatedButton(
                        onPressed: () async {
                          final inputText = emailToController.text;
                          _emailList.clear();
                          List<String> emails = inputText
                              .split(',')
                              .map((email) => email.trim())
                              .toList();
                          print('Before adding new emails: $_emailList');
                          print("Parsed emails: $emails");
                          _emailList.addAll(emails);
                          print('After adding new emails: $_emailList');

                          Map<String, dynamic>? schedule;
                          switch (_selectedIndex) {
                            case 1:
                              schedule = {'Time': formattedSelectedTime};
                              break;
                            case 2:
                              schedule = {
                                'Time': formattedSelectedTime,
                                'DayOfWeek': selectedDayOfWeek ?? 'monday'
                              };
                              break;
                            case 3:
                              schedule = {
                                'Time': formattedSelectedTime,
                                'Day': day ?? 1
                              };
                              break;
                            case 4:
                              schedule = {
                                'Date': selectedDate
                                        ?.toIso8601String()
                                        .split('T')
                                        .first ??
                                    DateTime.now()
                                        .toIso8601String()
                                        .split('T')
                                        .first,
                                'Time': formattedSelectedTime
                              };
                              break;
                            default:
                              schedule = null;
                          }

                          SendEmail sendNewMail = SendEmail(
                            name: nameController.text,
                            emailFrom: emailFromController.text,
                            password: passWordController.text,
                            emailTo: _emailList,
                            subject: subjectController.text,
                            body: bodyController.text,
                            sendType: _sendType,
                            scheduleOption: getScheduleOption(_selectedIndex),
                            schedule: schedule,
                            quantity: int.parse(quantityController.text),
                            attachments: attachmentsList,
                          );

                          sendEmailProvider.sendingEmail(sendNewMail);
                          print('time for button post $formattedSelectedTime');
                          print(
                              'DayOfCustom for button post ${selectedDate?.toIso8601String().split('T').first}');

                          // var email = SendEmail(
                          //   name: 'No Reply',
                          //   emailFrom: 'ti3n3t@gmail.com',
                          //   password: 'dhddrueunflsyfil',
                          //   emailTo: ['tientr.3t@gmail.com'],
                          //   subject: 'Test API no reply',
                          //   body: 'test send email',
                          //   quantity: 1,

                          //   // attachments: ['path/to/file.jpg'],
                          //   // other parameters...
                          // );
                          // sendEmailProvider.sendingEmail(email);
                          // // var emailService = SendEmailService();

                          // // await emailService.sendEmail(emailModel: email);
                        },
                        child: Text("Send"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
