import 'package:flutter/material.dart';
import 'package:student_app/API/custom_functions.dart';
import 'package:student_app/Utilities/custom_widgets.dart';

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({super.key});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {

  TextEditingController p1Controller = TextEditingController();
  TextEditingController p2Controller = TextEditingController();
  String? p1Error;
  String? p2Error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        ProperSizer(
            child: Column(
              children: [
                SizedBox(height:  MediaQuery.sizeOf(context).height/ 8,),
                CustomDesignLayout(
                  message: "Create Password",
                  withBackButton: false,
                  child: Column(
                    children: [

                      //enter password
                      CustomTextField(
                        isNumberController: false,
                        textController: p1Controller,
                        title: "Enter  Password",
                        ErrorText: p1Error,
                        shouldObscure: false,
                      ),
                      SizedBox(height: 32,),

                      //confirm password
                      CustomTextField(
                        isNumberController: false,
                        textController: p2Controller,
                        title: "Confirm  Password",
                        ErrorText: p2Error,
                        shouldObscure: true,
                      ),
                      SizedBox(height: 48,),

                      //update password
                      CustomButton(
                        onTap: (){
                          if(checkIfValidPassword(p1Controller.text)){
                            setState(() {
                              p1Error = "Minimum 8 characters\nAtleast one digit";
                            });
                          }
                          else if(p1Controller.text != p2Controller.text){
                            setState(() {
                              p2Error = "Password doesn't match";
                              p1Error = null;
                            });
                          }
                          else{
                            print('reset password');
                            Navigator.of(context).popUntil(ModalRoute.withName("/"));
                          }
                        },
                        buttonText: "Set Password",

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
