import 'dart:convert';

import 'package:http/http.dart' as http;


import 'UserModel.dart';
class APICode {
  
  Future<List<UserModel>> getDetails() async {
    var res = await http.get(Uri.parse("https://65fd2ce89fc4425c65314c58.mockapi.io/users"));
    print(res.statusCode);
    List<dynamic> userList = jsonDecode(res.body);
    List<UserModel> userModelList =[];
    for(int i=0;i<userList.length;i++){
      UserModel userModel = UserModel();
      userModel.userName = userList[i]["UserName"];
      userModel.userEmail=userList[i]["UserEmail"];

      userModel.userContact = userList[i]["UserContact"];
      userModel.userID=userList[i]["UserID"];

      userModelList.add(userModel);
    }
    return userModelList;
  }

  Future<void> deleteUser(String UserID) async {
    await http.delete(Uri.parse("https://65fd2ce89fc4425c65314c58.mockapi.io/users/"+UserID));
  }

  
}
