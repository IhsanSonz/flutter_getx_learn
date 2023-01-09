import 'package:flutter_getx_learn/middlewares/middlewares.dart';
import 'package:flutter_getx_learn/pages/pages.dart';
import 'package:get/get.dart';

const Transition _transition = Transition.leftToRightWithFade;
const Duration _transitionDuration = Duration(milliseconds: 500);

final appPages = [
  GetPage(
    name: '/',
    page: () => const SplashPage(),
    transition: _transition,
    transitionDuration: _transitionDuration,
  ),
  GetPage(
    name: '/login',
    page: () => const LoginPage(),
    transition: _transition,
    transitionDuration: _transitionDuration,
  ),
  GetPage(
    name: '/register',
    page: () => const RegisterPage(),
    transition: _transition,
    transitionDuration: _transitionDuration,
  ),
  GetPage(
    name: '/home',
    page: () => const MainTabPage(),
    transition: _transition,
    transitionDuration: _transitionDuration,
    middlewares: [
      AuthMiddleware(),
    ],
  ),
];
