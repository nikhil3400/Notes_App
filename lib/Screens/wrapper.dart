import 'package:flutter/material.dart';
import '../model/user.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Use>(context);

    //return either home or authenticate widget
    if(user == null)
    {
      return Authenticate();
    }
    else
    {
      return Home();
    }
  }
}
