import 'package:flutter/material.dart';
import 'package:task_manager/utils/color_consrants.dart';

import '../models/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.task,
    Key? key,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height / 14,
      child: Center(
        child: Text(
          task.taskname,
          style: const TextStyle(
            color: AppColors.maincolor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: const BoxDecoration(
        color: AppColors.textholder,
      ),
    );
  }
}
