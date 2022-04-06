import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:task_manager/services/user_service.dart';
import 'package:task_manager/utils/color_consrants.dart';
import 'package:task_manager/widget/buttonwidget.dart';
import 'package:task_manager/widget/dialog.dart';
import 'package:task_manager/widget/testfieldwidget.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController taskname = TextEditingController();
    TextEditingController taskdetails = TextEditingController();
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/addtask1.jpg'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.secondarycolor,
                size: 30,
              ),
            ),
            Column(
              children: [
                TextFieldWidget(
                  texttype: taskname,
                  hinttext: 'Task name',
                  borderradius: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  texttype: taskdetails,
                  maxlines: 3,
                  hinttext: 'Task Details',
                ),
                const SizedBox(
                  height: 20,
                ),
                Focus(
                  child: ButtonWidget(
                      backgroundcolor: AppColors.maincolor,
                      buttontext: 'Add',
                      buttontextcolor: AppColors.textholder,
                      onTapp: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (taskdetails.text.isEmpty || taskname.text.isEmpty) {
                          showsnackbar(context,
                              'The above fields must be filled to add a task');
                        } else {
                          String username =
                              context.read<UserService>().currentuser.username;
                          Task task = Task(
                              username: username,
                              taskname: taskname.text,
                              taskdetails: taskdetails.text,
                              created: DateTime.now());

                          if (context
                              .read<TaskService>()
                              .tasks
                              .contains(task)) {
                            showsnackbar(
                                context, 'Duplicate Task enter a new task');
                          } else {
                            String result = await context
                                .read<TaskService>()
                                .createtask(task);

                            if (result == 'ok') {
                              showsnackbar(
                                  context, 'New task successfully created ');
                              taskdetails.text = '';
                              taskname.text = '';
                              Navigator.pop(context);
                            } else {
                              showsnackbar(context, result);
                            }
                          }
                        }
                      }),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            )
          ],
        ),
      ),
    );
  }
}
