import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:teste_app/src/components/button/custom_button.dart';
import 'package:teste_app/src/components/loading/loading.dart';
import 'package:teste_app/src/components/text/custom_text.dart';
import 'package:teste_app/src/constants/colors.dart';
import 'package:teste_app/src/constants/mixins/screen_utils.dart';
import 'package:teste_app/src/entities/task.dart';
import 'package:teste_app/src/pages/edit_task/controllers/edit_task_controller.dart';
import 'package:teste_app/src/services/navigation_service.dart';

class EditTaskView extends GetView<EditTaskController> with ScreenUtilityMixin {
  final Task task;
  EditTaskView({
    super.key,
    required this.task,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Loading(
        show: controller.isLoading.value,
        child: Scaffold(
          bottomNavigationBar: SizedBox(
            height: setHeight(80),
            child: Column(
              children: [
                const Divider(),
                CustomButton(
                  width: setWidth(200),
                  height: setHeight(45),
                  labelButton: 'Editar Tarefa',
                  onTap: () async {
                    await controller.submitTask(task);
                  },
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context),
                  _buildTitleTasks(),
                  _buildDate(context),
                  _buildDescription(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: setWidth(16.0), vertical: setHeight(20.0)),
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
          TextFormField(
            controller: controller.descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descrição da sua tarefa',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),
        ],
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
            text: 'Criar tarefa',
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
            child: const Icon(
              Icons.info_outline,
              color: Colors.black,
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
      child: TextFormField(
        controller: controller.titleController,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          labelText: 'Título da Tarefa',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDate(BuildContext context) {
    var dateToday = formatDate(task.createdAt);
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
                      text: 'Inicio',
                      color: Colors.grey,
                      fontSize: 13.0,
                    ),
                    Customtext(
                      text: dateToday,
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ],
            ),
          ),
          Obx(() {
            var dateText = formatDate(controller.selectedEndDate.value);
            return GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate:
                      controller.selectedEndDate.value ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  String formattedDate = formatDate(pickedDate);
                  controller.updateEndDate(formattedDate);
                }
              },
              child: Container(
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
                          text: 'Fim',
                          color: Colors.grey,
                          fontSize: 13.0,
                        ),
                        Customtext(
                          text: dateText,
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'Selecione';
    return DateFormat('dd MMM yyyy', 'pt_BR').format(date);
  }
}
