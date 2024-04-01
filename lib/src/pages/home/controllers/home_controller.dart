import 'package:get/get.dart';
import 'package:teste_app/src/pages/tasks/controllers/tasks_controller.dart';

class HomeController extends GetxController {
  TasksController taskController = Get.find<TasksController>();

  RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  Future<void> refreshList() async {
    await taskController.loadUserDataAndTasks();
  }
}
