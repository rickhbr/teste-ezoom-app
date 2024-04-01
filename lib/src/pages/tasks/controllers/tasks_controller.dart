import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teste_app/src/entities/task.dart';
import 'package:teste_app/src/entities/user.dart';
import 'package:teste_app/src/services/apis/auth/auth_service.dart';
import 'package:teste_app/src/services/apis/tasks/tasks_service.dart';

class TasksController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool seeAll = false.obs;
  final RxInt selectedIndex = 0.obs;
  late TabController tabController;

  User? usuario;
  final AuthService _authService = AuthService();
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Hoje'),
    const Tab(text: 'Amanhã'),
    const Tab(text: 'Concluído'),
  ];

  RxList<Task> tasksList = RxList<Task>();
  RxList<Task> todayTasks = RxList<Task>();
  RxList<Task> tomorrowTasks = RxList<Task>();
  RxList<Task> completedTasks = RxList<Task>();

  @override
  void onInit() {
    super.onInit();
    loadUserDataAndTasks();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void changeTab(int index) {
    tabController.animateTo(index);
  }

  void handleSeeAll() {
    seeAll.value = !seeAll.value;
  }

  void filterTasks() {
    DateTime now = DateTime.now();
    String today = DateFormat('yyyy-MM-dd').format(now);
    String tomorrow =
        DateFormat('yyyy-MM-dd').format(now.add(const Duration(days: 1)));

    todayTasks.assignAll(tasksList
        .where((task) => task.dueDate == today && task.status != 'Concluido')
        .toList());
    tomorrowTasks.assignAll(tasksList
        .where((task) => task.dueDate == tomorrow && task.status != 'Concluido')
        .toList());
    completedTasks.assignAll(
        tasksList.where((task) => task.status == 'Concluido').toList());
  }

  Future<void> loadUserDataAndTasks() async {
    isLoading(true);
    try {
      usuario = await _authService.getUserData();

      var loadedTasks = await TasksService().getTasks();
      tasksList.assignAll(loadedTasks.map((e) => Task.fromJson(e)).toList());
      filterTasks();
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteTask(Task taskToDelete) async {
    isLoading(true);
    bool result = await TasksService().deleteTask(taskToDelete.id.toString());
    if (result) {
      tasksList.removeWhere((task) => task.id == taskToDelete.id);
      Get.back(result: true);
      Get.snackbar(
        "Sucesso",
        "Tarefa deletada com sucesso.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Erro",
        "Não foi possível deletar a tarefa.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading(false);
  }

  Future<void> deleteTaskOnBoard(Task taskToDelete) async {
    isLoading(true);
    bool result = await TasksService().deleteTask(taskToDelete.id.toString());
    if (result) {
      tasksList.removeWhere((task) => task.id == taskToDelete.id);

      Get.snackbar(
        "Sucesso",
        "Tarefa deletada com sucesso.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      await loadUserDataAndTasks();
    } else {
      Get.snackbar(
        "Erro",
        "Não foi possível deletar a tarefa.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading(false);
  }

  Future<void> updateTask(Task taskToUpdate, {bool isDone = false}) async {
    isLoading(true);
    bool result = await TasksService().updateTask(taskToUpdate, isDone: isDone);
    if (result) {
      Get.back(result: true);
      Get.snackbar(
        "Sucesso",
        "Tarefa atualizada com sucesso.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Erro",
        "Não foi possível atualizar a tarefa.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading(false);
  }
}
