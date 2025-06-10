bool checkIfPhoneNumber(value){
  RegExp re = RegExp(r'^[6-9][0-9]{9}');
  return re.hasMatch(value);
}

bool checkIfValidPassword(value){
  // RegExp re = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}');
  RegExp re = RegExp(r'^(?=.*?[0-9]).{8,}');
  return re.hasMatch(value);
}