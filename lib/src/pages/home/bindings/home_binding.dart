import 'package:get/get.dart';
import 'package:teste_app/src/pages/home/controllers/home_controller.dart';
import 'package:teste_app/src/pages/profile/controllers/profile_controller.dart';
import 'package:teste_app/src/pages/tasks/controllers/tasks_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

    Get.lazyPut<TasksController>(() => TasksController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
