import 'package:student_app/student_info.dart';

bool isExistingUser(String number){
  final studentData = Map<String, dynamic>.from(studentInfo);
  final students = studentData.keys.toList();
  if(students.contains(number)){
    return true;
  }
  else{
    return false;
  }
}

String getName(String number){
  if (isExistingUser(number)){
    final studentData = Map<String, dynamic>.from(studentInfo);
    return studentData[number]["name"];
  }
  else{
    return "";
  }
}

bool checkPassword(String name, String password){
  final studentData = Map<String, dynamic>.from(studentInfo);
  if (studentData[name]['password'] == password){return true;}
  else {return false;}
}

bool checkOTPValidity(otp){
  if(otp == "12345"){
    return true;
  }
  return false;
}

class Data {
  late String name;
  late String profileUrl;
  late String std;

  void changeData(String name, String profileUrl, String std){
    this.name = name;
    this.profileUrl = profileUrl;
    this.std = std;
  }

  Data(this.name, this.profileUrl, this.std);

}

int fetchData(String number){
  Data data = Data(studentInfo[number]!['name']!, studentInfo[number]!['profileUrl']!,studentInfo[number]!['std']!);
  int index = details.length;
  details[index] = data;
  return index;
}