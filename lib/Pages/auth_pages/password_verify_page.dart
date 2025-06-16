import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Pages/auth_pages/forgot_password_page.dart';
import 'package:student_app/Pages/home_skeleton.dart';
import '../../API/api.dart';
import '../../Utilities/colors.dart';
import '../../Utilities/Components/custom_widgets.dart';
import '../../Utilities/Components/custom_button.dart';
import '../../Utilities/Components/custom_textfield.dart';
import '../../Utilities/Components/proper_sizer.dart';

class PasswordVerifyPage extends StatefulWidget {
  final String number;
  const PasswordVerifyPage({super.key, required this.number});

  @override
  State<PasswordVerifyPage> createState() => _PasswordVerifyPageState();
}

class _PasswordVerifyPageState extends State<PasswordVerifyPage> {

  String password = "";
  String? _passwordErrorText;
  late String name;
  void initState(){
    super.initState();
    name = getName(widget.number);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: ProperSizer(
        child: Container(
          height: screenHeight/1.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage('assets/logo.png'),
              ),
              const SizedBox(
                height: 64,
              ),
              CustomDesignLayout(
                  message: "Login",
                  withBackButton: false,
                  child: Column(
                    children: [
                      DisabledTextField(
                        prefixIcon: Icon(Icons.phone),
                        title: "Mobile Number",
                        fieldText: widget.number,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomTextField(
                          isNumberController: false,
                          validate: (value){
                            password = value;
                          },
                          widgetErrorText: _passwordErrorText,
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          shouldObscure: true,
                          title: "Password"
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: (){
                            Get.to( () => ForgotPasswordPage(number: widget.number,),);
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: AppThemeColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        onTap: (){
                          if(checkPassword(widget.number,password)) {

                            int index = fetchData(widget.number);
                            Get.to( () =>  HomeSkeleton(index: index,));
                          }
                          else{
                            setState(() {
                              _passwordErrorText = "Incorrect Password";
                            });
                          }
                        },
                        buttonText: "Login"
                      )
                    ],
                  )
              )
            ],
          ),
        )
      ),
    );
  }
}

