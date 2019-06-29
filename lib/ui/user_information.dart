import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseintegration/model/user.dart';

class UserInformation extends StatefulWidget {
  final User user;
  UserInformation(this.user);
  @override
  _UserInformationState createState() => _UserInformationState();
}

final userReference = FirebaseDatabase.instance.reference().child('user');

class _UserInformationState extends State<UserInformation> {
  List<User> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information y Foto'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        height: 800.0,
        padding: const EdgeInsets.all(20.0),
        child: Card      (
          child: Center(
            child: Column(
              children: <Widget>[
                new Text(
                  "Name : ${widget.user.name}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                new Text(
                  "Codebar : ${widget.user.email}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                new Text(
                  "Description : ${widget.user.college}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                new Text(
                  "Price : ${widget.user.dept}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                new Text(
                  "Stock : ${widget.user.domain}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                Container(
                  height: 300.0,
                  width: 300.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
