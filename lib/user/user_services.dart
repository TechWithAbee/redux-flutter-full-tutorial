class UserService {
  static Future<String> getMessage() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return 'Hello, World!';
  }
}