
class LoginModel {

  String Phone;
  String Username;


  LoginModel(this.Phone, this.Username);

  LoginModel.map(Map<String, dynamic> map){
    Phone = map['phone'];
    Username = map['username'];
  }

}