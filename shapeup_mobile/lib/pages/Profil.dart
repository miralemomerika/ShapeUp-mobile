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

  Widget user() {
    return FutureBuilder<User>(
        future: GetUser(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return Container(
                height: 200,
                child: Container(child: usersProfile(snapshot.data)),
              );
            }
          }
        });
  }

  Widget usersProfile(user) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Container(
                alignment: Alignment.center,
                child: ClipOval(child: imageShow(user)),
              ),
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    _prefixIcon(Icons.people),
                                    Text("Ime i prezime",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(25, 0, 0, 20),
                              alignment: Alignment.centerLeft,
                              child: Text(user.firstName + " " + user.lastName,
                                  style: TextStyle(fontSize: 18)),
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    _prefixIcon(Icons.phone),
                                    Text(
                                      "Mobitel",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(25, 0, 0, 20),
                              alignment: Alignment.centerLeft,
                              child: Text(user.phoneNumber,
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                  children: [
                                    _prefixIcon(Icons.email),
                                    Text(
                                      "Email",
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)
                                    ),
                                  ],
                                ),
                              ),
                            Container(
                              margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text(user.email,
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ));
  }

  _prefixIcon(IconData iconData) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
      child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          margin: const EdgeInsets.only(right: 8.0),
          child: Icon(
            iconData,
            size: 30,
            color: Colors.lightBlue,
          )),
    );
  }

  Future<User> GetUser() async {
    var user = await HttpService.GetObj('Users/profile-info', null);

    return User.fromJson(user);
  }

  Widget imageShow(user) {
    if (user.slika != null && user.slika!.isNotEmpty) {
      return Image(
        image: MemoryImage(user.slika!),
        fit: BoxFit.cover,
        width: 150,
        height: 150,
      );
    }
    return Image(
      image: AssetImage('assets/no-image.png'),
      fit: BoxFit.cover,
      width: 150,
      height: 150,
    );
  }
}
