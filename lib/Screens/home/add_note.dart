import 'dart:io';
import 'package:date_field/date_field.dart';
import 'package:notes_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String inputTitle;
  String inputDescription;
  DateTime dateFrom = DateTime.now();
  DateTime dateTo = DateTime.now();
  DataBase obj;
  File pickedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text('Create New Event'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            TextField(
              autofocus: true,
              onChanged: (newText) {
                inputTitle = newText;
              },
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1,
                  fontStyle: FontStyle.italic,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[700], width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[700], width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 9,
              onChanged: (newText) {
                inputDescription = newText;
              },
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1,
                  fontStyle: FontStyle.italic,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[700], width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[700], width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(Icons.calendar_today,color: Colors.orange[700]),
                    SizedBox(width: 5),
                    Text(
                      'From',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Icon(Icons.calendar_today,color: Colors.orange[700]),
                    SizedBox(width: 5),
                    Text(
                      'To',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    SizedBox(height: 30),
                    Icon(Icons.attach_file,color: Colors.orange[700]),
                    SizedBox(width: 5),
                    Text(
                      'Attachment',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: DateTimeField(
                        onDateSelected: (DateTime value) {
                          setState(() {
                            dateFrom = value;
                          });
                        },
                        firstDate: DateTime(2000, 1),
                        lastDate: DateTime(2100),
                        selectedDate: dateFrom,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: DateTimeField(
                        onDateSelected: (DateTime value) {
                          setState(() {
                            dateTo = value;
                          });
                        },
                        firstDate: DateTime(2000, 1),
                        lastDate: DateTime(2100),
                        selectedDate: dateTo,
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: RaisedButton(
                        color: Colors.grey[100],
                        onPressed: () async {
                          FilePickerResult result = await FilePicker.platform
                              .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf', 'doc']);
                          setState(() {
                            pickedFile = File(result.files.single.path);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Upload File'),
                            Icon(Icons.cloud_upload,color: Colors.orange[700],)
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 45,
                    width: 170,
                    child: RaisedButton(
                      color: Colors.grey[100],
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Text('Cancel'),
                      ),
                    )),
                SizedBox(
                    height: 45,
                    width: 170,
                    child: RaisedButton(
                      color: Colors.orange[700],
                      onPressed: () async {
                        obj = new DataBase(
                            title: inputTitle,
                            description: inputDescription,
                            from: dateFrom,
                            to: dateTo,
                            file: pickedFile);
                        await obj.uploadData();
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
