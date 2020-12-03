import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Screens/update.dart';
import 'package:notes_app/services/database.dart';

class Details extends StatefulWidget {
  final String inputTitle;
  final String inputDescription;
  final DateTime dateFrom;
  final DateTime dateTo;
  final DataBase obj;
  final String url;
  final DocumentReference ref;

  Details(
      {this.inputTitle,
      this.inputDescription,
      this.dateFrom,
      this.dateTo,
      this.obj,
      this.url,
      this.ref});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final editButton = IconButton(
        icon: Icon(
          Icons.edit_outlined,
          color: Colors.deepOrange
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Update(
              title: widget.inputTitle,
              description: widget.inputDescription,
              from: widget.dateFrom,
              to: widget.dateTo,
              docRef: widget.ref
            );
          }));
        });

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height / 10),
        Icon(
          Icons.notes,
          color: Colors.white,
          size: 70.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          child: new Divider(color: Colors.white),
        ),
        SizedBox(height: 10.0),
        Text(
          widget.inputTitle.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 40.0,fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 30.0),
        Expanded(
            flex: 6,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  '${widget.dateFrom} - ${widget.dateTo}',
                  style: TextStyle(color: Colors.white),
                ))),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.orange[700]),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        Positioned(right: 8.0, top: 55.0, child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle
          ),
          child: editButton
          ))
      ],
    );

    final bottomContentText = Text(
      widget.inputDescription,
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => {},
          color: Colors.orange[700],
          child: Text("Download Docs", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
