import 'package:flutter/material.dart';
import 'package:notes_app/services/auth.dart';
import 'package:notes_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  //global key of type formstate it keeps track of state of our form
  final _formKey = GlobalKey<FormState>();

  //state for loading widget
  bool loading = false;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //text field state
  String email = ' ';
  String password = ' ';
  String error = ' ';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.orange[700],
              elevation: 0.0,
              title: Center(
                  child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              )),
            ),
            body: Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: "Enter an Email",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                  color: Colors.orange[700],
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an Email' : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: _toggle),
                              prefixIcon: Icon(Icons.lock),
                              labelText: "Enter a Password",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide(
                                  color: Colors.orange[700],
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: (val) => val.length < 6
                                ? 'Password should be at least 6 characters'
                                : null,
                            obscureText: _obscureText,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                            elevation: 1.0,
                            color: Colors.orange[700],
                            child: Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error =
                                        'Please supply a valid email or password';
                                  });
                                }
                              }
                            },
                          ),
                          SizedBox(height: 5.0),
                          Text('Or'),
                          GestureDetector(
                            child: Text("Don't have Account? Sign Up.",style: TextStyle(color:Colors.blue[700]),),
                            onTap: () async {
                              widget.toggleView();
                            },
                          )
                        ],
                      ),
                    ),
                  ]),
            )));
  }
}
