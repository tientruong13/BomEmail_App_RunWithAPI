import 'package:dio/dio.dart';
import 'send_email_model.dart'; // Assuming you named the file this way

class SendEmailService {
  final Dio _dio = Dio();

  // Base URL of your API
  final baseUrl = "http://10.0.2.2:5000";

  Future<SendEmail> sendEmail({required SendEmail emailModel}) async {
    SendEmail _sendEmail;
    try {
      Response response = await _dio.post(
        baseUrl + '/send_email',
        data: emailModel.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      Map<String, dynamic> responseData = response.data;
      print('User created: ${response.data}');
      print('Response status: ${responseData['status']}');
      _sendEmail = SendEmail.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        print("Error sending email: ${e.message}");
        print("Data: ${e.response?.data}");
        print("Headers: ${e.response?.headers}");
      } else {
        print("Error sending email: $e");
      }
      throw Exception("Failed to send email");
    }
    return _sendEmail;
  }

  Future<Response> cancelEmail(String taskId) async {
    try {
      final response = await _dio.post(
        '$baseUrl/cancel_email/$taskId',
      );
      return response;
    } catch (e) {
      print("Error cancelling email: $e");
      throw Exception("Failed to cancel email");
    }
  }

  Future<Response> listActiveJobs() async {
    try {
      final response = await _dio.get(
        '$baseUrl/list_active_jobs',
      );
      return response;
    } catch (e) {
      print("Error listing active jobs: $e");
      throw Exception("Failed to list active jobs");
    }
  }
}
