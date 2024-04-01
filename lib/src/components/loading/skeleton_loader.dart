import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:teste_app/src/constants/mixins/screen_utils.dart';

class TasksSkeletonLoader extends StatelessWidget with ScreenUtilityMixin {
  const TasksSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      containersColor: Colors.white,
      enabled: true,
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: setHeight(2.0), horizontal: setWidth(16.0)),
            child: Card(
              color: Colors.white,
              child: ListTile(
                title: Text('Item number $index as title'),
                subtitle: const Text('Subtitle here'),
              ),
            ),
          );
        },
      ),
    );
  }
}
