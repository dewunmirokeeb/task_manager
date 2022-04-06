import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/user.dart';
import 'package:task_manager/utils/color_consrants.dart';
import 'package:task_manager/widget/buttonwidget.dart';
import 'package:task_manager/widget/dialog.dart';
import 'package:task_manager/widget/testfieldwidget.dart';
import '../services/user_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController name;
  late TextEditingController username;
  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    name = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    name.dispose();
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
                Focus(
                  onFocusChange: (value) async {
                    if (!value) {
                      String result = await context
                          .read<UserService>()
                          .checkifuserexist(username.text.trim());
                      if (result == 'ok') {
                        context.read<UserService>().userexist = true;
                      } else {
                        context.read<UserService>().userexist = false;
                        if (!result.contains(
                            'The user does not exist in the database. please regster first')) {
                          showsnackbar(context, result);
                        }
                      }
                    }
                  },
                  child: TextFieldWidget(
                    texttype: username,
                    hinttext: 'enter username',
                    borderradius: 30,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Selector<UserService, bool>(
                  selector: (context, value) => value.userexist,
                  builder: (context, value, child) {
                    return value
                        ? const Text(
                            'User name exist please choose another username',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        : Container();
                  },
                ),
                TextFieldWidget(
                  texttype: name,
                  hinttext: 'enter your name',
                  borderradius: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    backgroundcolor: AppColors.maincolor,
                    buttontext: 'Register',
                    buttontextcolor: Colors.white,
                    onTapp: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (username.text.isEmpty || name.text.isEmpty) {
                        showsnackbar(context, 'Please enter all fields');
                      } else {
                        User newuser = User(
                          username: username.text.trim(),
                          name: name.text.trim(),
                        );
                        String result = await context
                            .read<UserService>()
                            .createuser(newuser);
                        if (result != 'ok') {
                          showsnackbar(context, result);
                        } else {
                          showsnackbar(
                              context, 'Account successfully created!');
                          Navigator.pop(context);
                        }
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
