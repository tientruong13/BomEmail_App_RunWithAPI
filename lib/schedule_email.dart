// import 'package:send_email/API_service.dart';
// import 'package:send_email/send_email_model.dart';

// class ScheduledEmail {
//   final String taskId;
//   final String description; // Something user-friendly

//   ScheduledEmail({required this.taskId, required this.description});
// }

// class EmailScheduler {
//   // This list can be part of some state management solution if needed.
//   List<ScheduledEmail> scheduledEmails = [];

//   final SendEmailService _sendEmailService = SendEmailService();

//   Future<void> scheduleEmail(SendEmail emailModel) async {
//     final response = await _sendEmailService.sendEmail(emailModel);

//     if (response.statusCode == 200) {
//       final taskId = response.data['task_id'];
//       final description =
//           "Email to ${emailModel.emailTo} at ${emailModel.schedule!['Time']}";
//       scheduledEmails
//           .add(ScheduledEmail(taskId: taskId, description: description));

//       // You can now update the UI, perhaps using a provider or another state management solution.
//     }
//   }
// }
