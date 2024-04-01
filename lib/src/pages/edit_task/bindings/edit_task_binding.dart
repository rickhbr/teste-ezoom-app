import 'package:get/get.dart';
import 'package:teste_app/src/pages/edit_task/controllers/edit_task_controller.dart';

class EditTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditTaskController>(() => EditTaskController());
  }
}
