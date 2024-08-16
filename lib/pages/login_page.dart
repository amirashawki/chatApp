import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frist_project/constant.dart';
import 'package:frist_project/helper/showSnackBar.dart';
import 'package:frist_project/pages/chat_page.dart';
import 'package:frist_project/pages/register_page.dart';

import 'package:frist_project/widgets/custom_button.dart';
import 'package:frist_project/widgets/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, passWord;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
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
                      'Login',
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
                  obscureText: true,
                  
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
                  text: 'Login ',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        var auth = FirebaseAuth.instance;
                        UserCredential user =
                            await auth.signInWithEmailAndPassword(
                                email: email!, password: passWord!);
                        Navigator.pushNamed(context, ChatPage.id ,arguments:email );
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          showSnackBar(context, 'User not found');
                        } else if (ex.code == 'wrong-password') {
                          showSnackBar(context, 'wrong password');
                        }
                      } catch (ex) {
                        print(ex);
                        showSnackBar(
                            context, 'there was an erorr ,please try later');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Text(
                        ' Register',
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
