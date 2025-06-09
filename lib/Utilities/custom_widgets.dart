import 'package:flutter/material.dart';
import 'package:student_app/Utilities/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textController;
  final bool isNumberController;
  Icon? prefixIcon;
  String? ErrorText;
  bool? shouldObscure;
  final String title;
  CustomTextField({super.key,required this.textController,required this.isNumberController, this.ErrorText,this.prefixIcon, this.shouldObscure,required this.title});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  String? _errorText;

  void checkError(String value){
    if(value.isEmpty){
        _errorText = "Can't be empty";
    }
    else{
        _errorText = null;
    }
  }

  @override
  void dispose(){
    widget.textController.dispose();
    super.dispose();
  }

  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: widget.textController, 
        builder: (context, TextEditingValue value, __){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width/0.2,
                // height: 20,
                child: TextFormField(

                  onChanged: (value){
                    checkError(value);
                    widget.ErrorText = null;
                  },
                  obscureText: (widget.shouldObscure == true)? passwordVisible : false,
                  controller: widget.textController,
                  keyboardType: widget.isNumberController? TextInputType.number : TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red,width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26,width: 1.2),
                      borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    errorText: _errorText ?? widget.ErrorText,
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: (widget.shouldObscure==true)? IconButton(
                        onPressed: (){
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                        },
                        icon: Icon(
                          passwordVisible? Icons.visibility :Icons.visibility_off,
                          color: Colors.black26,
                        ),
                    ): null,
                  ),

                ),
              ),
            ],
          );
        }
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function() onTap;
  const CustomButton({super.key,required this.buttonText,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: AppThemeColor,
            boxShadow: const [
              BoxShadow(
                offset: Offset(-2, 2),
                spreadRadius: 2,
                blurRadius: 2,
                color: Colors.black12
              )
            ]
        ),
        child: Align(
          alignment: const Alignment(0, 0),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
    );
  }
}

class ProperSizer extends StatelessWidget {
  final Widget child;
  const ProperSizer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: SizedBox(
            height: screenHeight,
            child: Center(
              child: child,
            ),
          )
        ),
      ),
    );
  }
}

class CustomDesignLayout extends StatelessWidget {
  final String message;
  final Widget child;
  final bool withBackButton;
  const CustomDesignLayout({super.key, required this.message, required this.child,required this.withBackButton});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: screenWidth/0.2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppThemeColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: screenWidth/2.4,
                child: Divider(
                  thickness: 4,
                  radius: BorderRadius.circular(32),
                  color: AppThemeColor,
                ),
              ),
              SizedBox(height: 48,),
              child,
            ],
          ),
          if(withBackButton == true)
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.black,
                  size: 24,
                ),
              )
            ),
        ],
      ),
    );
  }
}

class DisabledTextField extends StatelessWidget {
  final Icon prefixIcon;
  final String title;
  final String fieldText;
  const DisabledTextField({super.key,required this.prefixIcon,required this.title,required this.fieldText});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black26
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width/0.2,
          child: TextFormField(
            enabled: false,
            decoration: InputDecoration(
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26,width: 1.2),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              prefixIcon: prefixIcon,
              labelText: fieldText,
              labelStyle: TextStyle(
                color: Colors.black26,
              ),
            ),


          ),
        ),
      ],
    );
  }
}