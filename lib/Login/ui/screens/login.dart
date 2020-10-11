import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappneedzaio/Login/bloc/signin_graphQL.dart';
import 'package:flutterappneedzaio/Login/model/login_model.dart';
import 'package:flutterappneedzaio/utils/colors_palette.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginReturn extends StatelessWidget {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: LoginPage(),
      ), //,
    );

  }
}
class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements SinginGraphQLContract  {

  String authUser = """
  query authUser{
  users(
    options: {
      	operators: [
          {
          kind: LIKE
          field: "username"
          value: "Bret"
        }
        ]
    }
  ) {
    data{
      phone
      username
    }
  }
}
  """;
  String UsernameIndex;
  String PassIndex;
  bool ButtonSingIn = false;
  List<LoginModel> Usuarlist = new List<LoginModel>();
  SinginGraphQLPresenter _presenter;
  bool _obscuretext = true;
  final formKey = new GlobalKey<FormState>();
  BuildContext _context;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final ContainerKey = GlobalKey();
  //final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();


  _LoginPageState() {
    _presenter = new SinginGraphQLPresenter(this);
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _context = context;

    final cuerpo2 = MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        backgroundColor: ColorsPalette.PrincipaYellow,
        body: SingleChildScrollView(
          reverse: false,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/2,
                    width:  MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/2,
                    width:  MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(100))
                    ),
                    child: Container(
                        margin: EdgeInsets.only(bottom: 40, right: 40, left: 40),
                        child: Center(
                            child: Form(
                                key: formKey,
                                child: Wrap(
                                  runSpacing: 25,
                                  runAlignment: WrapAlignment.spaceEvenly,
                                  children: [

                                    //Username Field
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 40
                                        ),
                                        width:  MediaQuery.of(context).size.width,
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.spaceEvenly,
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            Icon(Icons.person_outline,
                                              color: ColorsPalette.SecundaryYellow,
                                              size: MediaQuery.of(context).size.width/15,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.8,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: "Username",
                                                ),
                                                autofocus: false,
                                                onSaved: (value) => {
                                                  setState(() {
                                                    _presenter.model.Username = value;
                                                  })
                                                },
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return "El campo usuario no puede quedar vacìo";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    //Password Field
                                    Container(
                                        width:  MediaQuery.of(context).size.width,
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.spaceEvenly,
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            Icon(Icons.lock_outline,
                                              color: ColorsPalette.SecundaryYellow,
                                              size: MediaQuery.of(context).size.width/15,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.8,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: "Password",
                                                ),
                                                autofocus: false,
                                                onSaved: (value) => {
                                                  setState(() {
                                                    _presenter.model.Phone = value;
                                                  })
                                                },
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return "El campo usuario no puede quedar vacìo";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                    ),

                                    InkWell(
                                      key: UniqueKey(),
                                      onTap: (){
                                        setState(() {
                                          submit();
                                        });
                                      },
                                      child: Container(
                                        key: ContainerKey,
                                        height: MediaQuery.of(context).size.height/15,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                          color: ColorsPalette.PrincipaYellow,
                                        ),
                                        child: ButtonSingIn != true ? Center(
                                            child: Text("SIGN IN",
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                  letterSpacing: 3,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: MediaQuery.of(context).size.height/40
                                                )
                                              ),)) :
                                        Query(
                                            options: QueryOptions(documentNode: gql("""
  query authUser{
  users(
    options: {
      	operators: [
          {
          kind: LIKE
          field: "username"
          value: "${_presenter.model.Username}"
        }
        ]
    }
  ) {
    data{
      phone
      username
    }
  }
}
  """)),
                                            builder: (QueryResult result, {fetchMore, refetch}){

                                              if (result.hasException) {
                                                return Text(result.exception.toString());
                                              }

                                              if (result.loading) {
                                                return Center(child: CircularProgressIndicator(),);
                                              }

                                              List Users = result.data['users']['data'];

                                              if(Users.length != 0){
                                                Usuarlist= Users.map((jason) => LoginModel.map(jason)).toList();

                                                String NameIndex = Usuarlist[0].Username;
                                                String PassIndex = Usuarlist[0].Phone;
                                                print(NameIndex);
                                                print(PassIndex);
                                                if(_presenter.model.Phone == PassIndex){
                                                  Future.delayed(Duration(seconds: 2),(){
                                                    Navigator.pushNamed(context, '/Home');
                                                  });
                                                  return Center(
                                                      child: Text("Bienvenido...",
                                                      style: GoogleFonts.montserrat(
                                                          textStyle: TextStyle(
                                                              letterSpacing: 3,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: MediaQuery.of(context).size.height/40
                                                          )
                                                      ),)
                                                  );

                                                }else{
                                                  stateButton();
                                                  return Center(
                                                    child: Text("Opss!! Bad Password",
                                                      style: GoogleFonts.montserrat(
                                                          textStyle: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: MediaQuery.of(context).size.height/40
                                                          )
                                                      ),),
                                                  );
                                                }
                                              }else{
                                                stateButton();
                                                return Center(
                                                  child: Text("Opss!! Bad Username",
                                                    style: GoogleFonts.montserrat(
                                                        textStyle: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: MediaQuery.of(context).size.height/40
                                                        )
                                                    ),),
                                                );

                                              }

                                            }
                                        ),
                                      )
                                    ),
                                    //SignIn Button
                                    /*RoundedLoadingButton(
                                      controller: _btnController,
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height/15,
                                      color: ColorsPalette.PrincipaYellow,
                                      child: Center(
                                        child: Text("SIGN IN", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height/40),),
                                      ),
                                      onPressed: (){
                                        _btnController.start();
                                        submit();
                                      },
                                    ),*/
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Don't have an account?",
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height/60,
                                                    color: ColorsPalette.Black1))
                                            ),

                                        InkWell(
                                          onTap: (){
                                            showSnackBar("Funcion no disponible");
                                          },
                                          child: Text("   SIGN UP",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height/55,
                                                      color: ColorsPalette.PrincipaYellow,
                                                  fontWeight: FontWeight.bold))
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                            )
                        )
                    ),
                  )
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/10),
                height: MediaQuery.of(context).size.height/2.1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/downrobot.png")
                    )
                ),
              ),

            ],

          )
        )
      ),
    );

    //================================================================================================================================================

    return cuerpo2;
  }

  submit() async {
    var form = formKey.currentState;
    if(form.validate()){
      setState(() {
        form.save();
        ButtonSingIn = true;
      });
    }else{
    }
  }

  stateButton(){
    print("Clase estado al Boton");
    Timer(const Duration(seconds: 1), () {
      print("Entro al TIMER");
      setState(() {
        ButtonSingIn = false;
        print("Se cambio el estado");
      });
    });
  }
  showSnackBar(String message) {
    setState(() {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message),
      ));

    });
  }
}
