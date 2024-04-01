import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teste_app/src/services/apis/tasks/tasks_service.dart';

class CreateTaskController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var selectedEndDate = Rx<DateTime?>(null);

  var formattedDate = Rx<String?>(null);

  RxBool isLoading = false.obs;

  void updateEndDate(String newDate) {
    formattedDate.value = newDate;
    selectedEndDate.value = DateFormat('dd MMM yyyy', 'pt_BR').parse(newDate);
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMM yyyy', 'pt_BR');
    return formatter.format(date);
  }

  Future<void> submitTask() async {
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

    var taskData = {
      "title": titleController.text,
      "description": descriptionController.text,
      "due_date": DateFormat('yyyy-MM-dd').format(selectedEndDate.value!),
      "status": "Pendente",
    };

    isLoading(true);

    var result = await TasksService().createTask(taskData);

    if (result) {
      Get.back(result: true);
      Get.snackbar(
        'Sucesso',
        'Tarefa criada com sucesso.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Erro',
        'Não foi possível criar a tarefa.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    isLoading(false);
  }
}
