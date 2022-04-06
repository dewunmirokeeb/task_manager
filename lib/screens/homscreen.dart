import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/user.dart';
import 'package:task_manager/route/routemanager.dart';
import 'package:task_manager/services/user_service.dart';
import 'package:task_manager/utils/color_consrants.dart';
import 'package:task_manager/widget/buttonwidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String? name;
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/welcome.jpg'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
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
            Selector<UserService, User>(selector: (context, value) {
              name = value.currentuser.name;
              return value.currentuser;
            }, builder: (context, value, child) {
              return RichText(
                text: TextSpan(
                  text: " Welcome $name",
                  style: const TextStyle(
                    color: AppColors.maincolor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            ButtonWidget(
              backgroundcolor: AppColors.maincolor,
              buttontext: 'Add Task',
              buttontextcolor: Colors.white,
              onTapp: () {
                Navigator.of(context).pushNamed(
                  RouteManager.addtaskscreen,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              backgroundcolor: AppColors.maincolor,
              buttontext: 'Add Notes',
              buttontextcolor: Colors.white,
              onTapp: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              backgroundcolor: AppColors.textholder,
              buttontext: 'View All',
              buttontextcolor: AppColors.smalltextcolor,
              onTapp: () {
                Navigator.of(context).pushNamed(
                  RouteManager.alltaskscreen,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
