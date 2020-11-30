import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Screens/home/add_note.dart';
import 'package:notes_app/Screens/home/note.dart';
import 'package:notes_app/services/auth.dart';
import 'package:wave_drawer/wave_drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  CollectionReference ref;
  List<int> _selected = new List<int>();
  List<DocumentReference> item = new List<DocumentReference>();

  @override
  void initState() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User currentUser = _auth.currentUser;
    ref = FirebaseFirestore.instance.collection(currentUser.uid);
    super.initState();
  }

  Widget getAppbar() {
    return (_selected.length > 0)
        ? AppBar(
            title: Text('${_selected.length} Note Selected'),
            backgroundColor: Colors.orange[700],
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  setState(() => _selected.clear());
                  for(DocumentReference r in item){
                    r.delete();
                  }
                  setState(() => item.clear());
                },
                icon: Icon(Icons.delete),
              )
            ],
          )
        : AppBar(
            backgroundColor: Colors.orange[700],
            title: Text('Notes'),
            centerTitle: true,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: getAppbar(),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data?.documents == null || !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return Container(
                color: (_selected.contains(index))
                    ? Colors.red.withOpacity(0.5)
                    : Colors.transparent,
                child: Note(
                  title: snapshot.data.documents[index].get('title'),
                  onTap: () {
                    if (_selected.contains(index)) {
                      setState(() => _selected.removeWhere((val) => val == index));
                      DocumentReference docRef = snapshot.data.documents[index].reference;
                      item.remove(docRef);
                    }
                    // Navigator.push(context, MaterialPageRoute(builder: (_){
                    //   return ; 
                    // }));
                  },
                  onLongPress: () {
                    if (!_selected.contains(index)) {
                      setState(() => _selected.add(index));
                      DocumentReference docRef = snapshot.data.documents[index].reference;
                      item.add(docRef);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      drawer: WaveDrawer(
        backgroundColor: Colors.white,
        boundaryColor: Colors.orange[700],
        boundaryWidth: 8.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Account Details',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(color: Colors.orange[700]),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                _auth.signOut();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return AddNote();
            }));
          },
          backgroundColor: Colors.orange[700],
          child: Icon(Icons.add)),
    );
  }
}
