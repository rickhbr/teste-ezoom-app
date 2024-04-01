import 'package:get/get.dart';
import 'package:teste_app/src/pages/create_task/bindings/create_task_binding.dart';
import 'package:teste_app/src/pages/create_task/views/create_task_view.dart';
import 'package:teste_app/src/pages/edit_task/bindings/edit_task_binding.dart';
import 'package:teste_app/src/pages/edit_task/views/edit_task_view.dart';
import 'package:teste_app/src/pages/home/bindings/home_binding.dart';
import 'package:teste_app/src/pages/home/views/home_view.dart';
import 'package:teste_app/src/pages/login/bindings/login_binding.dart';
import 'package:teste_app/src/pages/login/views/login_view.dart';
import 'package:teste_app/src/pages/splash/views/splash_view.dart';
import 'package:teste_app/src/pages/task_details/views/task_details_view.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: PagesRoutes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: PagesRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: PagesRoutes.tasksDetails,
      page: () => TaksDetailsView(task: Get.arguments),
      // binding: HomeBinding(),
    ),
    GetPage(
        name: PagesRoutes.createTask,
        page: () => CreateTaskView(),
        binding: CreateTaskBinding()
        // binding: HomeBinding(),
        ),
    GetPage(
        name: PagesRoutes.editTask,
        page: () => EditTaskView(task: Get.arguments),
        binding: EditTaskBinding()
        // binding: HomeBinding(),
        ),
  ];
}

abstract class PagesRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String perfil = '/perfil';
  static const String tasksDetails = '/tasksDetails';
  static const String createTask = '/createTask';
  static const String editTask = '/editTask';
}
