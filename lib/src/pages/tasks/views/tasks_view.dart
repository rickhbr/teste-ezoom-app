import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_app/src/components/cards/sorted_cards.dart';
import 'package:teste_app/src/components/cards/tasks_card.dart';
import 'package:teste_app/src/components/loading/loading.dart';
import 'package:teste_app/src/components/loading/skeleton_loader.dart';
import 'package:teste_app/src/components/text/custom_text.dart';
import 'package:teste_app/src/constants/colors.dart';
import 'package:teste_app/src/constants/mixins/screen_utils.dart';
import 'package:teste_app/src/entities/task.dart';
import 'package:teste_app/src/pages/tasks/controllers/tasks_controller.dart';
import 'package:teste_app/src/routes/app_routes.dart';
import 'package:teste_app/src/services/navigation_service.dart';

class TasksView extends GetView<TasksController> with ScreenUtilityMixin {
  TasksView({super.key});

  final List<Widget> myTabViews = [
    const Customtext(text: 'Hoje'),
    const Customtext(text: 'Amanhã'),
    const Customtext(text: 'Concluído'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.myTabs.length,
      child: Obx(
        () => Loading(
          show: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  SizedBox(height: setHeight(6.0)),
                  const Divider(),
                  SizedBox(height: setHeight(8.0)),
                  _buildTitleTasks(),
                  controller.seeAll.value
                      ? Expanded(
                          child: SortedTasksList(tasks: controller.tasksList))
                      : Expanded(
                          child: Column(
                            children: [
                              TabBar(
                                tabs: controller.myTabs,
                                indicatorColor: CustomColors.primaryColor,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                              ),
                              SizedBox(
                                height: setHeight(8.0),
                              ),
                              Expanded(
                                child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    _buildTasksList(controller.todayTasks),
                                    _buildTasksList(controller.tomorrowTasks),
                                    _buildTasksList(controller.completedTasks)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: setWidth(12.0), top: setHeight(12.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: CustomColors.primaryColor,
                minRadius: 20,
                maxRadius: 30,
                child: const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: setWidth(16.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Customtext(
                    text: 'Olá, ${controller.usuario?.name ?? 'Visitante'}!',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  if (controller.usuario != null)
                    Customtext(
                      text: controller.usuario?.email ?? '',
                      color: Colors.grey.shade500,
                      fontSize: setFontSize(13),
                    ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: setHeight(25),
          right: setWidth(12),
          child: GestureDetector(
            onTap: () async {},
            child: Icon(
              Icons.info_outline,
              color: CustomColors.terciaryColor,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleTasks() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: setWidth(16.0)),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Customtext(
              text: 'Minhas tarefas',
              color: Colors.black,
              fontSize: setFontSize(18),
              fontWeight: FontWeight.bold,
            ),
            GestureDetector(
              onTap: () {
                controller.handleSeeAll();
              },
              child: Customtext(
                text: controller.seeAll.value ? 'Ver menos' : 'Ver todas',
                color: CustomColors.primaryColor,
                fontSize: setFontSize(13),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTasksList(RxList<Task> tasks) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const TasksSkeletonLoader();
      } else if (tasks.isEmpty) {
        return Center(
          child: Column(
            children: [
              Text(
                'Sem tarefas',
                style: TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: setHeight(8.0),
              ),
              const Text(
                'Nenhuma tarefa para este período.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: () async {
          await controller.loadUserDataAndTasks();
        },
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            return Padding(
              padding: EdgeInsets.only(
                  left: setWidth(16.0),
                  right: setWidth(16.0),
                  bottom: setHeight(12.0)),
              child: TasksCards(
                onTap: () async {
                  var result = await NavigationService.pushWithParamsArgs(
                      PagesRoutes.tasksDetails,
                      arguments: task);

                  if (result == true) {
                    await controller.loadUserDataAndTasks();
                  }
                },
                onPressedDelete: (context) async {
                  await controller.deleteTaskOnBoard(task);
                },
                onPressedEdit: (context) async {
                  bool result = await NavigationService.pushWithParamsArgs(
                      PagesRoutes.editTask,
                      arguments: task);
                  if (result) {
                    await controller.loadUserDataAndTasks();
                  }
                },
                titleTask: task.title,
                timeTask: task.dueDate,
                priorityTask: task.status,
              ),
            );
          },
        ),
      );
    });
  }
}
