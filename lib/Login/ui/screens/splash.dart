import 'dart:convert';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappneedzaio/utils/colors_palette.dart';
import 'dart:async';
import 'package:flutterappneedzaio/utils/persister.dart' as global;
import 'package:rounded_loading_button/rounded_loading_button.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    _requestPermissionsLocation();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      home: Scaffold(
        key: UniqueKey(),
        backgroundColor: ColorsPalette.PrincipaYellow,
        body: Container(
          child: Column(
            children: [
            Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.all(40),
                  child: Wrap(
                    runSpacing: 30,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runAlignment: WrapAlignment.end,
                    children: [
                      Center(
                        child: Text("USERAPP",
                            style: TextStyle(fontSize: MediaQuery.of(context).size.height/25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Center(
                        child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam",
                            style: TextStyle(fontSize: MediaQuery.of(context).size.height/55,
                                color: Colors.black), textAlign: TextAlign.center,),
                      ),
                      RoundedLoadingButton(
                        controller: _btnController,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/15,
                        color: Colors.black,
                        child: Center(
                          child: Text("IR A LOGIN", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height/40),),
                        ),
                        onPressed: (){
                          _btnController.start();
                          print(global.PermissionOk);
                          Future.delayed(Duration(seconds: 2),(){
                            if(global.PermissionOk == true){
                              _btnController.success();
                              Future.delayed(Duration(seconds: 1),(){
                                _btnController.reset();
                                Navigator.pushNamed(context, '/Login');
                              });
                            }else{
                              _btnController.error();
                              Future.delayed(Duration(seconds: 1),(){
                                _btnController.reset();
                                _requestPermissionsLocation();
                              });

                            }
                          });
                        },

                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/50,
                      )
                    ],
                  ),
                ),),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/roboto.png"),
                        fit: BoxFit.contain
                      )
                  ),
                ),)
            ],
          ),
        ),
      ),
    );
  }

  _requestPermissionsLocation() async {
    final permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'NeedZaio',
      appNameColor: Color(0xFFCC123B),
      cancelText: 'Cancelar',
      enableLocationMessage:
      'Debe habilitar los permisos necesarios para utilizar la acción.',
      goToSettingsText: 'Ir a Configuraciones',
      permissionSettingsMessage:
      'Necesita habilitar los permisos necesarios para que la aplicación funcione correctamente',
    );
    var result = await permissionValidator.location();
    if (result == true) {
      print("Se concedieron los permisos $result");
      setState(() {
        global.PermissionOk = true;
      });
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Advertencia!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            content: new Text("Si deseas loguearte sera necesario conceder los permisos requeridos, de lo contrario no podras continuar", style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Entendido", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }
}

