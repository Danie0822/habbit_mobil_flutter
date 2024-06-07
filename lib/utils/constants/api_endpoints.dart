class ApiEndpoints {
  static const String ip = '192.168.1.5'; 
  static const String port = '4000';
  static const String baseUrl = 'http://$ip:$port/api';

  static const String login = '$baseUrl/auth/login';
  static const String signUp = '$baseUrl/auth/signup';
  static const String getUserProfile = '$baseUrl/user/profile';
}
