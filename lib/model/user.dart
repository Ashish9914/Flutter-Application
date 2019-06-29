import 'package:firebase_database/firebase_database.dart';

class User {
  String _id;
  String _name;
  String _email;
  String _college;
  String _dept;
  String _domain;

  User(this._id, this._name, this._email, this._college, this._dept,
      this._domain);

  User.map(dynamic obj) {
    this._name = obj['name'];
    this._email = obj['email'];
    this._college = obj['college'];
    this._dept = obj['dept'];
    this._domain = obj['domain'];
  }

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get college => _college;
  String get dept => _dept;
  String get domain => _domain;

  User.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _email = snapshot.value['email'];
    _college = snapshot.value['college'];
    _dept = snapshot.value['dept'];
    _domain = snapshot.value['domain'];
  }
}
