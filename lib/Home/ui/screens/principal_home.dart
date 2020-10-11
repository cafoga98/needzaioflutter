import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappneedzaio/Home/model/model_contacts.dart';
import 'package:flutterappneedzaio/utils/colors_palette.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeReturn extends StatelessWidget {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: PrincipalHome(),
      ), //,
    );

  }
}

class PrincipalHome extends StatefulWidget {
  @override
  _PrincipalHomeState createState() => _PrincipalHomeState();
}

class _PrincipalHomeState extends State<PrincipalHome> {

  bool StateButton1 = true;
  bool StateButton2 = false;
  bool StateButton3 = false;
  bool StateButton4 = false;

  List<ListadoUsers> Usuarlist = new List<ListadoUsers>();

  final String getContacts = """
  query getContact{
  users(options: {paginate: {page:1}}){
    data {
      id
      name
      username
      email
      albums(options: {paginate: {limit:1}}){
        data{
          photos(options: {paginate:{limit: 1}}){
            data{
              url
              thumbnailUrl
            }
          }
        }
      }
    }
  }
}
  """;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
        key: GlobalKey(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.grey,
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      child: StateButton1 == true ? Container(
                          width: MediaQuery.of(context).size.height/12,
                          height: MediaQuery.of(context).size.height/22,
                          margin: EdgeInsets.all(2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.home,color: Colors.black),
                              Center(
                                  child: Text('Home', style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.height/70))
                              )
                            ],
                          )
                      ) : Container(
                          width:MediaQuery.of(context).size.height/30,
                          margin: EdgeInsets.all(2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.home,color: Colors.black),
                            ],
                          )
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      color: StateButton1 == true ? ColorsPalette.PrincipaYellow : Colors.white,
                      onPressed: () {
                        setState(() {
                          StateButton1 = true;
                          StateButton2 = false;
                          StateButton3 = false;
                          StateButton4 = false;
                        });

                      },

                    ),
                    FlatButton(
                      child: StateButton2 == true ? Container(
                          width: MediaQuery.of(context).size.height/10,
                          height: MediaQuery.of(context).size.height/22,
                          margin: EdgeInsets.all(2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.message,color: Colors.black,),
                              Center(
                                  child: Text('Msg', style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.height/70),)
                              )
                            ],
                          )
                      ) : Container(
                          width:MediaQuery.of(context).size.height/30,
                          margin: EdgeInsets.all(2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.message,color: Colors.black,),
                            ],
                          )
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      color: StateButton2 == true ? ColorsPalette.PrincipaYellow : Colors.white,
                      onPressed: (){
                        setState(() {
                          StateButton1 = false;
                          StateButton2 = true;
                          StateButton3 = false;
                          StateButton4 = false;
                        });

                      },

                    ),
                    FlatButton(
                      child: StateButton3 == true ? Container(
                          width: MediaQuery.of(context).size.height/12,
                          height: MediaQuery.of(context).size.height/22,
                          margin: EdgeInsets.all(2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.favorite_border,color: Colors.black,),
                              Center(
                                  child: Text('Likes', style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.height/70),)
                              )
                            ],
                          )
                      ) : Container(
                          width:MediaQuery.of(context).size.height/30,
                          margin: EdgeInsets.all(2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.favorite_border,color: Colors.black,),
                            ],
                          )
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      color: StateButton3 == true ? ColorsPalette.PrincipaYellow : Colors.white,
                      onPressed: () {
                        setState(() {
                          StateButton1 = false;
                          StateButton2 = false;
                          StateButton3 = true;
                          StateButton4 = false;
                        });
                      },

                    ),
                    FlatButton(
                      child: StateButton4 == true ? Container(
                          width: MediaQuery.of(context).size.height/12,
                          height: MediaQuery.of(context).size.height/22,
                          margin: EdgeInsets.all(2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.person_outline,color: Colors.black,),
                              Center(
                                  child: Text('Profile', style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.height/70),)
                              )
                            ],
                          )
                      ) : Container(
                          width:MediaQuery.of(context).size.height/30,
                          margin: EdgeInsets.all(2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.person_outline,color: Colors.black,),
                            ],
                          )
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      color: StateButton4 == true ? ColorsPalette.PrincipaYellow : Colors.white,
                      onPressed: () {
                        setState(() {
                          StateButton1 = false;
                          StateButton2 = false;
                          StateButton3 = false;
                          StateButton4 = true;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 30, left: 30, right: 30),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text("CONTACTOS", style: GoogleFonts.montserrat(
              textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: MediaQuery.of(context).size.height/45))),
              Container(
                margin: EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height/1.25,
                child: Query(
                    options: QueryOptions(documentNode: gql(getContacts)),
                    builder: (QueryResult result, {fetchMore, refetch}){

                      if (result.hasException) {
                        return Text(result.exception.toString());
                      }

                      if (result.loading) {
                        return Center(child: CircularProgressIndicator(),);
                      }

                      List Users = result.data['users']['data'];
                      Usuarlist= Users.map((jason) => ListadoUsers.map(jason)).toList();

                      return ListView.builder(
                        primary: true,
                        itemCount: Usuarlist.length,
                        itemBuilder: (context, index){

                          String linkUrl = Usuarlist[index].Albums.Data[0].Photos.Data[0].Url;
                          String NameIndex = Usuarlist[index].Name;
                          String EmailIndex = Usuarlist[index].Email;

                          return Container(
                            height: MediaQuery.of(context).size.height/13,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: ColorsPalette.PrincipaYellow.withOpacity(0.5),
                              borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.height/13,
                                      width: MediaQuery.of(context).size.height/13,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40)),
                                      ),
                                      child: Image.network(
                                        linkUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 20
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(NameIndex, style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(fontWeight: FontWeight.bold)
                                            ),),
                                            Text(EmailIndex, style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(fontWeight: FontWeight.normal)
                                            ))
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                                
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                    child: Icon(Icons.arrow_forward_ios, size: MediaQuery.of(context).size.height/34, color: ColorsPalette.PrincipaYellow,))
                              ],
                            ),
                          );
                        },

                      );

                    }
                )
              )
            ],
          )
        ),
    );
  }
}
