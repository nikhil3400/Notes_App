import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  final String title;
  final String description;
  final Function onLongPress;
  final Function onTap;

  Note({this.title, this.description, this.onLongPress, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 7,
        child: Card(
          elevation: 10,
          shadowColor: Colors.orange[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            onTap: onTap,
            onLongPress: onLongPress,
            title: Text(
              title.toUpperCase(),
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.orange[700]),
            ),
            subtitle: Text(
              description,
              maxLines: 2,
              style: TextStyle(letterSpacing: 0.5, color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}
