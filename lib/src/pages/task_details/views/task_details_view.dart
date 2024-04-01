import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:teste_app/src/components/button/custom_button.dart';
import 'package:teste_app/src/components/text/custom_text.dart';
import 'package:teste_app/src/constants/colors.dart';
import 'package:teste_app/src/constants/mixins/screen_utils.dart';
import 'package:teste_app/src/entities/task.dart';
import 'package:teste_app/src/pages/tasks/controllers/tasks_controller.dart';
import 'package:teste_app/src/services/navigation_service.dart';

class TaksDetailsView extends GetView<TasksController> with ScreenUtilityMixin {
  final Task task;
  TaksDetailsView({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              _buildTitleTasks(),
              _buildDate(),
              _buildDescription(),
              const Divider(),
              SizedBox(
                height: setHeight(8.0),
              ),
              _buildProgressBar(task.dueDate),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: setWidth(16.0), vertical: setHeight(20.0)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Customtext(
              text: 'Descrição',
              fontWeight: FontWeight.bold,
              fontSize: setFontSize(12.0),
              color: Colors.black,
            ),
            SizedBox(
              height: setHeight(8.0),
            ),
            Customtext(
              text: task.description,
              fontWeight: FontWeight.normal,
              fontSize: setFontSize(12.0),
              textAlign: TextAlign.justify,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: setWidth(12.0), vertical: setHeight(12.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              NavigationService.goBack();
            },
            child: Container(
              width: setWidth(40),
              height: setHeight(40),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(60)),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          const Customtext(
            text: 'Detalhes da tarefa',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          Container(
            width: setWidth(40),
            height: setHeight(40),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(60)),
            child: PopupMenuButton<String>(
              color: Colors.white,
              onSelected: (value) async {
                String title = 'Confirmar';
                String message = value == 'excluir'
                    ? 'Tem certeza de que deseja excluir esta tarefa?'
                    : 'Tem certeza de que deseja marcar esta tarefa como concluída?';

                if (task.status != "Concluido") {
                  bool confirmed =
                      await showConfirmationDialog(context, title, message);
                  if (confirmed) {
                    if (value == 'excluir') {
                      await controller.deleteTask(task);
                    } else if (value == 'concluir') {
                      if (task.status == "Concluido") {
                        null;
                      } else {
                        await controller.updateTask(task, isDone: true);
                      }
                    }
                  }
                } else if (value == "excluir") {
                  bool confirmed =
                      await showConfirmationDialog(context, title, message);
                  if (confirmed) {
                    if (value == 'excluir') {
                      await controller.deleteTask(task);
                    } else if (value == 'concluir') {
                      if (task.status == "Concluido") {
                        null;
                      } else {
                        await controller.updateTask(task, isDone: true);
                      }
                    }
                  }
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'excluir',
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: setWidth(4.0),
                        ),
                        const Customtext(
                          text: 'Excluir Tarefa',
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'concluir',
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: task.status == "Concluido"
                              ? Colors.grey
                              : Colors.green,
                        ),
                        SizedBox(
                          width: setWidth(4.0),
                        ),
                        Customtext(
                          text: 'Concluir Tarefa',
                          color: task.status == "Concluido"
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ],
                    ),
                  ),
                ];
              },
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(String dueDateString) {
    DateTime dueDate = DateFormat('yyyy-MM-dd').parse(dueDateString);

    DateTime startOfDueDate =
        DateTime(dueDate.year, dueDate.month, dueDate.day);
    DateTime endOfDueDate =
        DateTime(dueDate.year, dueDate.month, dueDate.day, 23, 59);

    DateTime now = DateTime.now();

    if (now.isAfter(endOfDueDate)) {
      return _progressBarWidget(1.0, 0);
    }

    if (now.isBefore(startOfDueDate)) {
      int totalHours = endOfDueDate.difference(startOfDueDate).inHours;
      return _progressBarWidget(0.0, totalHours);
    }

    int hoursPassed = now.difference(startOfDueDate).inHours;
    int totalHours = endOfDueDate.difference(startOfDueDate).inHours;
    double progress = hoursPassed / totalHours.toDouble();
    int hoursLeft = totalHours - hoursPassed;

    return _progressBarWidget(progress, hoursLeft);
  }

  Widget _progressBarWidget(double progress, int hoursLeft) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Customtext(
            text: 'Progresso',
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: Colors.black,
          ),
          const SizedBox(height: 8.0),
          Center(
            child: CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 13.0,
              animation: true,
              percent: task.status == 'Concluido' ? 1 : progress,
              center: Text(
                task.status == 'Concluido'
                    ? "100%"
                    : "${(progress * 100).toStringAsFixed(0)}%",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: Text(
                task.status == 'Concluido'
                    ? "Tarefa Concluída"
                    : "Horas restantes: ${hoursLeft}h",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: CustomColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleTasks() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: setWidth(16.0), vertical: setHeight(16.0)),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Customtext(
              text: task.title,
              color: Colors.black,
              fontSize: setFontSize(18),
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDate() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: setWidth(16.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: setWidth(150),
            height: setHeight(80),
            decoration: BoxDecoration(
              color: CustomColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  color: CustomColors.primaryColor,
                  size: 30,
                ),
                SizedBox(
                  width: setWidth(12.0),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Customtext(
                      text: 'Criado',
                      color: Colors.grey,
                      fontSize: 13.0,
                    ),
                    Customtext(
                      text: formatIsoStringToDate(task.createdAt.toString()),
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            width: setWidth(150),
            height: setHeight(80),
            decoration: BoxDecoration(
              color: CustomColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  color: CustomColors.primaryColor,
                  size: 30,
                ),
                SizedBox(
                  width: setWidth(12.0),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Customtext(
                      text: 'Validade',
                      color: Colors.grey,
                      fontSize: 13.0,
                    ),
                    Customtext(
                      text: formatIsoStringToDate(task.dueDate.toString()),
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> showConfirmationDialog(
      BuildContext context, String title, String message) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      onTap: () => Navigator.of(context).pop(false),
                      labelButton: 'Cancelar',
                      color: Colors.red,
                      width: setWidth(100),
                    ),
                    SizedBox(
                      width: setWidth(8.0),
                    ),
                    CustomButton(
                      onTap: () => Get.back(result: true),
                      labelButton: 'Confirmar',
                      width: setWidth(100),
                    ),
                  ],
                )
              ],
            );
          },
        ) ??
        false;
  }

  String formatIsoStringToDate(String isoDateString) {
    // Convertendo a string ISO 8601 para um objeto DateTime.
    DateTime dateTime = DateTime.parse(isoDateString);

    // Configurando o formato de saída desejado.
    // 'dd MMM yyyy' para dia, mês abreviado e ano.
    // 'pt_BR' para garantir que o mês seja exibido em português.
    String formattedDate = DateFormat('dd MMM yyyy', 'pt_BR').format(dateTime);

    // Substituindo pontos por nada, já que o DateFormat inclui um ponto após o mês abreviado.
    formattedDate = formattedDate.replaceFirst('.', '');

    return formattedDate;
  }
}
