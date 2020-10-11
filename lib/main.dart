import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterappneedzaio/Home/ui/screens/principal_home.dart';
import 'package:flutterappneedzaio/Login/ui/screens/login.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutterappneedzaio/Login/ui/screens/splash.dart';


void main() {
  runApp(MyApp());
}

class Prueba extends StatefulWidget {

  @override
  _PruebaState createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final HttpLink httpLink = new HttpLink(uri: 'https://graphqlzero.almansi.me/api');
  @override
  Future<void> initState() {
    print('Iniciando el metod --> initState()');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final ValueNotifier<GraphQLClient> client = new ValueNotifier<GraphQLClient>(
        GraphQLClient(
            link: httpLink,
            cache: InMemoryCache())
    );

    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          title: 'TestNeedZAIO',
          theme: ThemeData(

            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          onGenerateRoute: (settings){
            switch  (settings.name){
              case '/':
                print('INICIALIZANDO ACTIVITY SPLASH');
                return MaterialPageRoute(builder: (context) => new Splash());
              case '/Login':
                print('INICIALIZANDO ACTIVITY LOGIN');
                return MaterialPageRoute(builder: (context) => new LoginReturn());
              case '/Home':
                print('INICIALIZANDO ACTIVITY LOGIN');
                return MaterialPageRoute(builder: (context) => new HomeReturn());

              default:
              // Página de error
                return null;
            }
          },
        )
    );
  }
}

