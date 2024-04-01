import 'package:get/get.dart';
import 'package:teste_app/src/pages/create_task/controllers/create_task_controller.dart';

class CreateTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTaskController>(() => CreateTaskController());
  }
}
