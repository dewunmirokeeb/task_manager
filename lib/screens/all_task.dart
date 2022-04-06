import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:task_manager/utils/color_consrants.dart';
import 'package:task_manager/widget/all_task_screen_icon_widgets.dart';
import 'package:task_manager/widget/buttonwidget.dart';
import 'package:task_manager/widget/drawerwidget.dart';
import 'package:task_manager/widget/task_card.dart';

class AllTaskScreen extends StatelessWidget {
  const AllTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height / 3.2,
            padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/header1.jpg'),
              ),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.secondarycolor,
                size: 30,
              ),
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5, right: 20),
              ),
              AllTaskScreenIconWidgets(
                iconsize: 30,
                icon: Icons.home,
                onPressed: () {},
              ),
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 15,
                child: AllTaskScreenIconWidgets(
                  iconsize: 15,
                  icon: Icons.add_outlined,
                  onPressed: () {},
                  iconcolor: AppColors.textholder,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
              ),
              AllTaskScreenIconWidgets(
                iconsize: 30,
                icon: Icons.calendar_view_month_sharp,
                onPressed: () {},
              ),
              const Text(
                '2',
                style: TextStyle(fontSize: 20, color: AppColors.secondarycolor),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Flexible(
            child: Consumer<TaskService>(
              builder: ((context, value, child) {
                return ListView.builder(
                    itemCount: value.tasks.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        background: DrawerWidget(
                          align: Alignment.centerLeft,
                          icon: Icons.edit,
                          backgroundcolorcolor:
                              AppColors.smalltextcolor.withOpacity(0.5),
                        ),
                        secondaryBackground: const DrawerWidget(
                          icon: Icons.delete,
                          backgroundcolorcolor: Colors.red,
                          align: Alignment.center,
                        ),
                        onDismissed: (DismissDirection direction) {},
                        confirmDismiss: (DismissDirection direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (_) {
                                  return Container(
                                    height: 550,
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.maincolor.withOpacity(0.4),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ButtonWidget(
                                            backgroundcolor:
                                                AppColors.maincolor,
                                            buttontext: 'View',
                                            buttontextcolor:
                                                AppColors.textholder,
                                            onTapp: () {},
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ButtonWidget(
                                            backgroundcolor:
                                                AppColors.maincolor,
                                            buttontext: 'Edit',
                                            buttontextcolor:
                                                AppColors.textholder,
                                            onTapp: () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                            return false;
                          } else {
                            return Future.delayed(
                              const Duration(seconds: 1),
                              () => direction == DismissDirection.endToStart,
                            );
                          }
                        },
                        key: ObjectKey(index),
                        child: TaskCard(
                          task: value.tasks[index],
                        ),
                      );
                    });
              }),
            ),
          ),
        ],
      ),
    );
  }
}
