class LoginRepository{

  Future<bool> login(String email,  String secret) async{
    if(email == 'adm' && secret == '123'){
      return true;
    }else{
      throw Exception('Erro ao logar');
    }
  }


}