import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_app/Pages/password_verify_page.dart';
import 'package:student_app/Utilities/custom_widgets.dart';

import '../API/api.dart';
import '../API/custom_functions.dart';
import 'otp_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String number;
  ForgotPasswordPage({super.key,required this.number});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late TextEditingController numberController = TextEditingController();
  String? _pnoErrorText;

  @override
  void initState(){
    super.initState();
    numberController.text = widget.number;
  }

  @override
  void dispose(){
    numberController.dispose();
    super.dispose();
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
                        textController: numberController,
                        isNumberController: false,
                        shouldObscure: false,
                        ErrorText: _pnoErrorText,
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      CustomButton(
                        onTap: (){
                          String value = numberController.text;
                          if(!checkIfPhoneNumber(value)){
                            setState(() {
                              _pnoErrorText = "Invalid Mobile Number";
                            });
                          }
                          else if(isExistingUser(value)) {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(builder: (context) => OtpPage(number: value,setOrReset: "reset",))
                            );
                            _pnoErrorText = null;
                          }
                          else{
                            setState(() {
                              _pnoErrorText = null;
                            });
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

