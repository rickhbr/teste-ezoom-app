import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_app/src/routes/app_routes.dart';

abstract class NavigationService {
  static Future<dynamic> push(String route) async {
    return await Get.toNamed(route);
  }

  static void pushTransition(Widget page) {
    Get.to(page,
        transition: Transition.fade, duration: const Duration(seconds: 1));
  }

  static Future<dynamic> pushWithParamsArgs(String routeName,
      {Object? arguments}) async {
    return await Get.toNamed(routeName, arguments: arguments);
  }

  static void goToSplashAndRemoveEverything() {
    Get.offAllNamed(PagesRoutes.splash);
  }

  static void pushWithParams({
    required String route,
    required Map<String, dynamic> params,
  }) {
    Get.toNamed(route, arguments: params);
  }

  static void replace(String route) {
    Get.offNamed(route);
  }

  static void replaceWithParams({
    required String route,
    required Map<String, dynamic> params,
  }) {
    Get.offNamed(route, arguments: params);
  }

  static void goBack() {
    Get.back();
  }
}
