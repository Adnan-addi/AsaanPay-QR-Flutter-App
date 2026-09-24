import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthApiService {
  static const String baseUrl = 'http://asaanpay.co:4770/api/internal';

  static const Map<String, String> _headers = {
    'API-KEY': 'YOUR_API_KEY',
    'SECRET-KEY': 'YOUR_SECRET_KEY',
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  Future<Map<String, dynamic>> login({
    required String phone,
    required String password,
    required String deviceId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/token'),
      headers: _headers,
      body: {'phone': phone, 'password': password, 'device_id': deviceId},
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String verificationToken,
    required String emailOtp,
    required String phoneOtp,
    required String deviceId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/otp-verify'),
      headers: _headers,
      body: {
        'verification_token': verificationToken,
        'email_otp': emailOtp,
        'phone_otp': phoneOtp,
        'device_id': deviceId,
      },
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String businessName,
    required String email,
    required String phone,
    required String address,
    required String city,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: _headers,
      body: {
        'name': name,
        'business_name': businessName,
        'email': email,
        'phone': phone,
        'address': address,
        'city': city,
        'password': password,
      },
    );

    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    dynamic decoded;

    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      decoded = null;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      return {'success': true, 'message': response.body};
    }

    String message = 'Something went wrong';

    if (decoded is Map<String, dynamic>) {
      message =
          decoded['message']?.toString() ??
          decoded['error']?.toString() ??
          decoded['detail']?.toString() ??
          message;
    }

    throw Exception(message);
  }
}
