import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseintegration/model/user.dart';

String filename;

class UserScreen extends StatefulWidget {
  final User user;
  UserScreen(this.user);
  @override
  _UserScreenState createState() => _UserScreenState();
}

final userReference = FirebaseDatabase.instance.reference().child('user');

class _UserScreenState extends State<UserScreen> {
  List<User> items;

  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _collegeController;
  TextEditingController _deptController;
  TextEditingController _domainController;

  //nuevo imagen
  String productImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController(text: widget.user.name);
    _emailController = new TextEditingController(text: widget.user.email);
    _collegeController = new TextEditingController(text: widget.user.college);
    _deptController = new TextEditingController(text: widget.user.dept);
    _domainController = new TextEditingController(text: widget.user.domain);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Users'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        //height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[],
                ),
                TextField(
                  controller: _nameController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Name'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _emailController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'email'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _collegeController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.list), labelText: 'college'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _deptController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.monetization_on), labelText: 'dept'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                ),
                Divider(),
                TextField(
                  controller: _domainController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.shop), labelText: 'domain'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                ),
                Divider(),
                FlatButton(
                    onPressed: () {
                      //nuevo imagen
                      if (widget.user.id != null) {
                        userReference.child(widget.user.id).set({
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'college': _collegeController.text,
                          'dept': _deptController.text,
                          'domain': _domainController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      } else {
                        //nuevo imagen
                        userReference.push().set({
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'college': _collegeController.text,
                          'dept': _deptController.text,
                          'domain': _domainController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: (widget.user.id != null)
                        ? Text('Update')
                        : Text('Add')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
