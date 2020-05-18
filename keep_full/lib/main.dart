import 'package:flutter/material.dart';
import './Widgets/IntroScreen.dart';
import './Widgets/HomePage.dart';
import './Models/AppKeepFull.dart';

App app = App();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static final mainPageRoute = (context) => FutureBuilder(
        future: app.getUser().timeout(Duration(seconds: 2), onTimeout: null),
        initialData: null,
        builder: mainPageRouteBuilder,
      );

  static Widget mainPageRouteBuilder(
      BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
    List<Widget> children;
    if (snapshot.hasData) {
      print(snapshot.data);
      if (snapshot.data["userFirstName"]?.isNotEmpty ?? false) {
        return HomePage(snapshot.data);
      } else {
        return IntroScreen();
      }
    } else {
      children = <Widget>[
        SizedBox(
          child: CircularProgressIndicator(),
          width: 60.0,
          height: 60.0,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
        )
      ];
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keep Full',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: App.primarySwatch,
        iconTheme: IconThemeData(color: Color.fromRGBO(230, 74, 19, 1)),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: IntroScreen(),
      onGenerateInitialRoutes: (_) => [
        MaterialPageRoute(builder: mainPageRoute),
      ],
    );
  }
}

