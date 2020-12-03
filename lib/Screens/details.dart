import 'package:flutter/material.dart';
import 'package:notes_app/Screens/update.dart';
import 'package:notes_app/services/database.dart';

class Details extends StatefulWidget {
  String inputTitle;
  String inputDescription;
  DateTime dateFrom;
  DateTime dateTo;
  DataBase obj;
  String url;

  Details(
      {this.inputTitle,
        this.inputDescription,
        this.dateFrom,
        this.dateTo,
        this.obj,
        this.url});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  @override
  Widget build(BuildContext context) {

    final downloadButton = IconButton(icon: Icon(Icons.edit_outlined,color: Colors.white,), onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return Update();
      }));
    });

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Icon(
          Icons.notes,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.white),
        ),
        SizedBox(height: 10.0),
        Text(
          widget.inputTitle,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      '${widget.dateFrom} - ${widget.dateTo}',
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 1, child: downloadButton),
          ],
        ),
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
        )
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
          child:
          Text("Download Docs", style: TextStyle(color: Colors.white)),
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
        children: <Widget>[topContent,bottomContent],
      ),
    );
  }
}
