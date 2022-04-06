import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/route/routemanager.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:task_manager/services/user_service.dart';
import 'package:task_manager/utils/color_consrants.dart';
import 'package:task_manager/widget/buttonwidget.dart';
import 'package:task_manager/widget/dialog.dart';
import 'package:task_manager/widget/testfieldwidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController username;
  @override
  void initState() {
    super.initState();
    username = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                text: "Hello",
                style: TextStyle(
                  color: AppColors.maincolor,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '\nStart your beautiful day',
                    style: TextStyle(
                      color: AppColors.smalltextcolor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                TextFieldWidget(
                  texttype: username,
                  hinttext: 'enter username',
                  borderradius: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    backgroundcolor: AppColors.maincolor,
                    buttontext: 'Continue',
                    buttontextcolor: Colors.white,
                    onTapp: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (username.text.isEmpty) {
                        showsnackbar(
                            context, 'Please Enter your user name to login');
                      } else {
                        String result = await context
                            .read<UserService>()
                            .getuser(username.text.trim());
                        if (result != 'ok') {
                          showsnackbar(context, result);
                        } else {
                          String username =
                              context.read<UserService>().currentuser.username;
                          await context.read<TaskService>().gettasks(
                                username,
                              );
                          Navigator.of(context)
                              .pushNamed(RouteManager.homescreen);
                        }
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RouteManager.registrationscreen);
                  },
                  child: RichText(
                    text: const TextSpan(
                        text: "Dont have an account ?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "....Register",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
