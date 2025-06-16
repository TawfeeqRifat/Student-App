import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final bool isNumberController;
  Icon? prefixIcon;
  String? widgetErrorText;
  bool? shouldObscure;
  final String title;
  String? initialValue;
  final String? Function(String)? validate;

  CustomTextField({super.key,
    required this.isNumberController,
    this.widgetErrorText,
    this.validate,
    this.prefixIcon,
    this.shouldObscure,
    required this.title,
    this.initialValue
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  final TextEditingController textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String? errorText;
  String? _errorText;

  String textValue = '';

  void updateChanges(){
    setState(() {
      errorText = widget.validate!(textValue);
    });
  }
  void checkError(String value){
    if(value.isEmpty){
      _errorText = "Can't be empty";
    }
    else{
      _errorText = null;
    }
  }

  @override
  void initState(){
    super.initState();
    if( widget.initialValue!= null) {
      textController.text = widget.initialValue!;
      textValue = widget.initialValue!;
    }
    _focusNode.addListener(_onFocusChange);
  }
  @override
  void dispose(){
    textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      updateChanges();
    }
  }
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: textController,
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
                  onFieldSubmitted: (_) {
                    updateChanges();
                  },
                  onTapOutside: (_){
                    updateChanges();
                  },
                  focusNode: _focusNode,
                  onChanged: (value){
                    textValue = value;
                    checkError(value);
                    errorText = null;
                  },
                  obscureText: (widget.shouldObscure == true)? passwordVisible : false,
                  controller: textController,
                  keyboardType: widget.isNumberController? TextInputType.number : TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.2),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26,width: 1.2),
                        borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    errorText: _errorText ?? errorText ?? widget.widgetErrorText,
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