import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:student_app/API/custom_functions.dart';
import 'package:student_app/Utilities/custom_widgets.dart';

import 'login_page.dart';

class PasswordChangePage extends StatefulWidget {
  final String setOrReset;
  const PasswordChangePage({super.key,required this.setOrReset});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  String password1 = "";
  String password2 = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        ProperSizer(
          child: Column(
            children: [
              SizedBox(height:  MediaQuery.sizeOf(context).height/ 8,),
              CustomDesignLayout(
                message: widget.setOrReset=="reset"? "Reset Password" : "Create Password",
                withBackButton: false,
                child: Column(
                  children: [

                    //enter password
                    CustomTextField(
                      isNumberController: false,
                      title: "Enter  Password",
                      validate: (value){
                        password1 = value;
                        if(!checkIfValidPassword(value)){
                            return "Minimum 8 characters\nAtleast one digit";
                        }
                        return null;
                      },
                      shouldObscure: false,
                    ),
                    SizedBox(height: 32,),

                    //confirm password
                    CustomTextField(
                      isNumberController: false,
                      title: "Confirm  Password",
                      validate: (value){
                        password2 = value;
                        if(password1 != password2){
                          return "Password doesn't match";
                        }
                        return null;
                      },
                      shouldObscure: true,
                    ),
                    SizedBox(height: 48,),

                    //update password
                    CustomButton(
                      onTap: (){
                        if(password1 == password2 && checkIfValidPassword(password1)){
                          print('reset/set password!');
                          Get.offAll(() => LoginPage());
                        }
                      },
                      buttonText: (widget.setOrReset == "reset")? "Update Password" : "Set Password",

                    )
                  ],
                ),
              ),
            ],
          )
        )
    );
  }
}
