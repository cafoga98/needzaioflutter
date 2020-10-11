import 'package:flutter/material.dart';
import 'package:flutterappneedzaio/Login/model/login_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class SinginGraphQLContract{

}

class SinginGraphQLPresenter {

  SinginGraphQLContract _view;
  LoginModel _model;

  LoginModel get model => _model;

  SinginGraphQLPresenter(SinginGraphQLContract view){
    _view = view;
    _model = new LoginModel("", "");
  }

  SinginGraphQLPresenter.user(
      SinginGraphQLContract view,
      String username,
      String phone,
      ){
    _view = view;
    _model = new LoginModel(username,phone);
  }

}