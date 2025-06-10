import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_app/Pages/auth_pages/password_verify_page.dart';
import 'package:student_app/Utilities/custom_widgets.dart';

import '../../API/api.dart';
import '../../API/custom_functions.dart';
import 'otp_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String number;
  ForgotPasswordPage({super.key,required this.number});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  String number = '';

  @override
  void initState(){
    super.initState();
    number = widget.number;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: ProperSizer(
          child: Column(
            children: [
              SizedBox(height: screenHeight/8,),
              CustomDesignLayout(
                  message: "Forgot Password",
                  withBackButton: true,
                  child: Column(
                    children: [
                      Text(
                        "Please enter your mobile no. to reset the password",
                        style: TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 32,),
                      CustomTextField(
                        title: "Mobile Number",
                        prefixIcon: Icon(Icons.phone),
                        isNumberController: false,
                        shouldObscure: false,
                        initialValue: widget.number,
                        validate: (value){
                          number = value;
                          if(!checkIfPhoneNumber(number)){
                            return "Invalid Mobile Number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      CustomButton(
                        onTap: (){
                          if(checkIfPhoneNumber(number) && isExistingUser(number)) {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(builder: (context) => OtpPage(number: number,setOrReset: "reset",))
                            );
                          }
                        },
                        buttonText: "Reset Password",
                      )
                    ],
                  )
              ),
            ],
          )
      ),
    );
  }
}

