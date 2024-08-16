import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frist_project/constant.dart';
import 'package:frist_project/helper/showSnackBar.dart';
import 'package:frist_project/pages/chat_page.dart';
import 'package:frist_project/widgets/custom_button.dart';
import 'package:frist_project/widgets/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? text;

  String? email;

  String? passWord;

  GlobalKey<FormState> fromKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white54,
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: fromKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 120,
                ),
                Image.asset(
                  KLogo,
                  height: 100,
                ),
                Center(
                  child: Text(
                    'Scholar Chat',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: 'pacifico'),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  obscureText: true,
                  onChanged: (data) {
                    email = data;
                  },
                  validate: (data) {
                    if (data!.isEmpty) {
                      return 'Field is required';
                    }
                  },
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  onChanged: (data) {
                    passWord = data;
                  },
                  validate: (data) {
                    if (data!.length <= 7) {
                      return 'at least 8 numbers';
                    }
                  },
                  hintText: 'password',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onTap: () async {
                    if (fromKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        var auth = FirebaseAuth.instance;
                        UserCredential user =
                            await auth.createUserWithEmailAndPassword(
                                email: email!, password: passWord!);
                        Navigator.pushNamed(context, ChatPage.id ,arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnackBar(context, 'week password');
                        } else if (ex.code == 'email-already-exit') {
                          showSnackBar(context, 'email already exit');
                        }
                      } catch (ex) {
                        showSnackBar(
                            context, 'there was an erorr ,please try later');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  text: 'Register',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        ' Login',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
