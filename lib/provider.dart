import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:send_email/API_service.dart';
import 'package:send_email/send_email_model.dart';

class SendEmailProvider extends ChangeNotifier {
  final SendEmailService _sendEmailService = SendEmailService();
  Future<void> sendingEmail(SendEmail email) async {
    await _sendEmailService.sendEmail(emailModel: email);
    notifyListeners();
  }

  Future<List<String>> pickFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    List<String> filesList = [];

    if (result != null) {
      for (var platformFile in result.files) {
        File file = File(platformFile.path!);
        String base64File = base64Encode(file.readAsBytesSync());
        filesList.add(base64File);
      }
    }
    return filesList;
  }

  // Future<List<String>?> pickFiles() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowMultiple: true, // This enables multi-picking
  //     // other configurations like type, allowedExtensions, etc. go here
  //   );

  //   if (result != null) {
  //     List<String> paths = result.paths
  //         .map((path) => path!)
  //         .toList(); // Convert list of nullable strings to non-nullable strings
  //     return paths;
  //   } else {
  //     return null;
  //   }
  // }
}
