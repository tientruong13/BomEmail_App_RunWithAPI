class SendEmail {
  final String name;
  final String emailFrom;
  final String password;
  final List<String> emailTo;
  final String subject;
  final String body;
  final List<String>? attachments;
  final String scheduleOption;
  final Map<String, dynamic>? schedule;
  final int quantity;
  final String sendType;

  SendEmail({
    required this.name,
    required this.emailFrom,
    required this.password,
    required this.emailTo,
    required this.subject,
    required this.body,
    this.attachments,
    this.schedule,
    this.scheduleOption = 'now',
    this.quantity = 1,
    this.sendType = 'Single',
  });

  // Convert a SendEmail object into a Map object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'emailFrom': emailFrom,
      'passWord': password,
      'emailTo': emailTo,
      'Subject': subject,
      'body': body,
      'ScheduleOption': scheduleOption,
      'Schedule': schedule,
      'quantily': quantity,
      'sendType': sendType,
    };
    if (attachments != null) {
      data['attachs'] = attachments;
    }
    return data;
  }

  // Convert a Map object into a SendEmail object
  factory SendEmail.fromJson(Map<String, dynamic> json) {
    return SendEmail(
      name: json['name'] ?? '',
      emailFrom: json['emailFrom'] ?? '',
      password: json['passWord'] ?? '',
      emailTo:
          json['emailTo'] is List ? List<String>.from(json['emailTo']) : [],
      subject: json['Subject'] ?? '',
      body: json['body'] ?? '',
      attachments:
          (json['attachs'] != null) ? List<String>.from(json['attachs']) : null,
      scheduleOption: json['ScheduleOption'] ?? 'now',
      schedule: (json['Schedule'] != null)
          ? Map<String, dynamic>.from(json['Schedule'])
          : null,
      quantity: json['quantily'] ?? 1,
      sendType: json['sendType'] ?? 'Single',
    );
  }
}
