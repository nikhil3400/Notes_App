import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  final String title;
  final Function onLongPress;
  final Function onTap;

  Note({this.title, this.onLongPress, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 6,
        child: Card(
          elevation: 10,
          shadowColor: Colors.orange[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            onTap: onTap,
            onLongPress: onLongPress,
            leading: Icon(Icons.note),
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  color: Colors.orange[700]),
            ),
            subtitle: Text(
              //'123456789101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899100',
              'hello this is a dummy test and this is just a simple sentence.',
              maxLines: 3,
              style: TextStyle(letterSpacing: 0.5, color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
