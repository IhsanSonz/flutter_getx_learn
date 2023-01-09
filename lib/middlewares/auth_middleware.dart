part of 'middlewares.dart';

class AuthMiddleware extends GetMiddleware {
  final store = GetStorage();
  final AuthController _auth = AuthController.to;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  RouteSettings? redirect(String? route) {
    return firebaseAuth.currentUser != null
        ? null
        : const RouteSettings(name: '/login');
  }
}
