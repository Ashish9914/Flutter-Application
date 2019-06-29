import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseintegration/model/user.dart';
import 'package:firebaseintegration/ui/user_information.dart';
import 'package:firebaseintegration/ui/user_screen.dart';

class ListViewUser extends StatefulWidget {
  @override
  _ListViewState createState() => _ListViewState();
}

final userReference = FirebaseDatabase.instance.reference().child('user');

class _ListViewState extends State<ListViewUser> {
  List<User> items;
  StreamSubscription<Event> _onProductAddedSubscription;
  StreamSubscription<Event> _onProductChangedSubscription;

  @override
  void initState() {
    super.initState();
    items = new List();
    _onProductAddedSubscription =
        userReference.onChildAdded.listen(_onProductAdded);
    _onProductChangedSubscription =
        userReference.onChildChanged.listen(_onProductUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    _onProductAddedSubscription.cancel();
    _onProductChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Products List'),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.only(top: 3.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 1.0,
                    ),
                    Container(
                      padding: new EdgeInsets.all(3.0),
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            //nuevo imagen
                            Expanded(
                              child: ListTile(
                                  title: Text(
                                    '${items[position].name}',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${items[position].college}',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  onTap: () => _navigateToProductInformation(
                                      context, items[position])),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () => _showDialog(context, position),
                            ),

                            //onPressed: () => _deleteProduct(context, items[position],position)),
                            IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () => _navigateToProduct(
                                    context, items[position])),
                          ],
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.pinkAccent,
          onPressed: () => _createNewProduct(context),
        ),
      ),
    );
  }

  //nuevo para que pregunte antes de eliminar un registro
  void _showDialog(context, position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.purple,
              ),
              onPressed: () => _deleteProduct(
                    context,
                    items[position],
                    position,
                  ),
            ),
            new FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onProductAdded(Event event) {
    setState(() {
      items.add(new User.fromSnapShot(event.snapshot));
    });
  }

  void _onProductUpdate(Event event) {
    var oldProductValue =
        items.singleWhere((user) => user.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldProductValue)] =
          new User.fromSnapShot(event.snapshot);
    });
  }

  void _deleteProduct(BuildContext context, User user, int position) async {
    await userReference.child(user.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
        Navigator.of(context).pop();
      });
    });
  }

  void _navigateToProductInformation(BuildContext context, User user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserScreen(user)),
    );
  }

  void _navigateToProduct(BuildContext context, User user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserInformation(user)),
    );
  }

  void _createNewProduct(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UserScreen(User(null, '', '', '', '', ''))),
    );
  }
}
