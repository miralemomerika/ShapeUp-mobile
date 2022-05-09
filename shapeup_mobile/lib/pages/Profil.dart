import 'package:flutter/material.dart';
import 'package:shapeup_mobile/models/User.dart';
import 'package:shapeup_mobile/services/HttpService.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  _Profil createState() => _Profil();
}

class _Profil extends State<Profil> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Column(
        children: [
          Expanded(
            child: user(),
          ),
        ],
      ),
    );
  }

  Widget user () {
    return FutureBuilder<User>(
      future: GetUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        else {
          if(snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'),);
          }
          else {
            return Container(
              height: 200,
              child: Container(
                child: usersProfile(snapshot.data)
              ),
            );
          }
        }
      }
    );
  }

  Widget usersProfile (user) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [ 
          SizedBox(
            height: 200,
            child: Container(
              alignment: Alignment.center,
              child: ClipOval(
                child: imageShow(user),
              ),
            ),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          alignment: Alignment.centerLeft,
                          child: Text("Ime", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          alignment: Alignment.centerLeft,
                          child: Text(user.firstName, style: TextStyle(fontSize: 20,),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          alignment: Alignment.centerLeft,
                          child: Text("Prezime", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          alignment: Alignment.centerLeft,
                          child: Text(user.lastName, style: TextStyle(fontSize: 20,),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          alignment: Alignment.centerLeft,
                          child: Text("Mobitel", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          alignment: Alignment.centerLeft,
                          child: Text(user.phoneNumber, style: TextStyle(fontSize: 20,),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          alignment: Alignment.centerLeft,
                          child: Text("Email", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(user.email, style: TextStyle(fontSize: 20,),),
                        ),
                      ],
                    ),
                  )
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Future<User> GetUser () async {
    var user = await HttpService.GetObj('Users/profile-info', null);

    return User.fromJson(user);
  }

  Widget imageShow (user) {
    if(user.slika != null && user.slika!.isNotEmpty){
      return Image(image: MemoryImage(user.slika!), fit: BoxFit.cover, width: 125, height: 125,);
    }
    return Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover, width: 125, height: 125,);
  }
}