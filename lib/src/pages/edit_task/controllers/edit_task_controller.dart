import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teste_app/src/entities/task.dart';
import 'package:teste_app/src/services/apis/tasks/tasks_service.dart';

class EditTaskController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  var selectedEndDate = Rx<DateTime?>(null);

  var formattedDate = Rx<String?>(null);

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final Task task = Get.arguments;

    titleController = TextEditingController(text: task.title);
    descriptionController = TextEditingController(text: task.description);
    selectedEndDate.value = DateFormat('yyyy-MM-dd').parse(task.dueDate);
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void updateEndDate(String newDate) {
    formattedDate.value = newDate;
    selectedEndDate.value = DateFormat('dd MMM yyyy', 'pt_BR').parse(newDate);
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMM yyyy', 'pt_BR');
    return formatter.format(date);
  }

  Future<void> submitTask(Task task) async {
    if (selectedEndDate.value == null) {
      Get.snackbar(
        'Erro',
        'Por favor, selecione uma data de fim.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    isLoading(true);

    Task taskData = Task(
        id: task.id,
        title: titleController.text,
        description: descriptionController.text,
        status: task.status,
        dueDate: selectedEndDate.value.toString(),
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
        userId: task.userId);

    var result = await TasksService().updateTask(taskData);

    if (result) {
      Get.back(result: true);
      Get.snackbar(
        'Sucesso',
        'Tarefa atualizada com sucesso.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Erro',
        'Não foi atualizar a tarefa.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    isLoading(false);
  }
}
