import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:teste_app/src/components/text/custom_text.dart';
import 'package:teste_app/src/constants/mixins/screen_utils.dart';

class TasksCards extends StatefulWidget {
  final String titleTask;
  final String timeTask;
  final String priorityTask;
  final void Function()? onTap;
  final void Function(BuildContext)? onPressedDelete;
  final void Function(BuildContext)? onPressedEdit;
  const TasksCards({
    super.key,
    required this.titleTask,
    required this.timeTask,
    required this.priorityTask,
    this.onTap,
    this.onPressedDelete,
    this.onPressedEdit,
  });

  @override
  State<TasksCards> createState() => _TasksCardsState();
}

class _TasksCardsState extends State<TasksCards> with ScreenUtilityMixin {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: widget.onPressedDelete,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Deletar',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: widget.onPressedEdit,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Editar',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: setHeight(70),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.5, color: Colors.grey),
              color: Colors.white),
          child: Row(
            children: [
              Container(
                width: setWidth(10),
                height: setHeight(70),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: widget.priorityTask == "Pendente"
                      ? Colors.orange
                      : Colors.green,
                ),
              ),
              SizedBox(
                width: setWidth(12.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: setHeight(12.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Customtext(
                      text: widget.titleTask,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    Customtext(
                      text:
                          '${formatDueDate(widget.timeTask)} - ${capitalizeFirstLetter(widget.priorityTask)}',
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      fontSize: setFontSize(12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return "";
    return text[0].toUpperCase() + text.substring(1);
  }

  String formatDueDate(String dueDate) {
    try {
      final dateTime = DateFormat('yyyy-MM-dd').parse(dueDate);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return dueDate;
    }
  }
}
