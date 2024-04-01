import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teste_app/src/components/cards/tasks_card.dart';
import 'package:teste_app/src/entities/task.dart';
import 'package:teste_app/src/constants/colors.dart';
import 'package:teste_app/src/pages/tasks/controllers/tasks_controller.dart';
import 'package:teste_app/src/routes/app_routes.dart';
import 'package:teste_app/src/services/navigation_service.dart';

class SortedTasksList extends StatelessWidget {
  final RxList<Task> tasks;

  SortedTasksList({super.key, required this.tasks});

  final TasksController taskController = Get.find<TasksController>();

  @override
  Widget build(BuildContext context) {
    List<Task> sortedTasks = tasks.toList();
    sortedTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));

    var groupedTasks = groupTasksByDate(sortedTasks);

    return ListView(
      children: groupedTasks.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                formatDate(entry.key),
                style: TextStyle(
                    color: CustomColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            ...entry.value.map((task) => Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0, right: 18.0, bottom: 12.0),
                  child: Align(
                    child: TasksCards(
                      titleTask: task.title,
                      priorityTask: task.status,
                      timeTask: task.dueDate,
                      onTap: () async {
                        var result = await NavigationService.pushWithParamsArgs(
                            PagesRoutes.tasksDetails,
                            arguments: task);

                        if (result == true) {
                          await taskController.loadUserDataAndTasks();
                        }
                      },
                      onPressedDelete: (context) async {
                        await taskController.deleteTaskOnBoard(task);
                      },
                      onPressedEdit: (context) async {
                        bool result =
                            await NavigationService.pushWithParamsArgs(
                                PagesRoutes.editTask,
                                arguments: task);
                        if (result) {
                          await taskController.loadUserDataAndTasks();
                        }
                      },
                    ),
                  ),
                )),
          ],
        );
      }).toList(),
    );
  }

  String formatDate(String dateStr) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(dateStr);
    return DateFormat('dd MMM yyyy', 'pt_BR').format(date);
  }

  Map<String, List<Task>> groupTasksByDate(List<Task> tasks) {
    return tasks.fold<Map<String, List<Task>>>({},
        (Map<String, List<Task>> map, task) {
      (map[task.dueDate] ??= []).add(task);
      return map;
    });
  }
}
