import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';
import '../Widgets/home_page.dart';
import '../Models/models.dart';
import '../Blocs/blocs.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _userFirstNameController = TextEditingController();
  final _userLastNameController = TextEditingController();

  FocusNode userFirstNameFocusNode;
  FocusNode userLastNameFocusNode;

  void _saveUser() async {
    User user = User();
    user.logIn(
      firstName: _userFirstNameController.text,
      lastName: _userLastNameController.text,
    );
    BlocProvider.of<AuthenticationBloc>(context).add(
      LoggedIn(user),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/appLogo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Welcome",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: "First Name:",
                          contentPadding: EdgeInsets.all(6.0)),
                      controller: _userFirstNameController,
                      onSubmitted: (_) => userLastNameFocusNode.requestFocus(),
                    ),
                    TextField(
                      focusNode: userLastNameFocusNode,
                      decoration: InputDecoration(
                          labelText: "Last Name:",
                          contentPadding: EdgeInsets.all(6.0)),
                      controller: _userLastNameController,
                      onSubmitted: (_) => _saveUser,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                        onPressed: _saveUser,
                        child: Text("Sign Up"),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
