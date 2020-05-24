import 'package:flutter/material.dart';

import '../Widgets/Developer.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical:20.0),
              child: Image.asset(
                './assets/images/appLogo.png',
                fit: BoxFit.contain,
                height: 150.0,
                width: 150.0,
              ),
            ),

            Text(
              'KEEP FULL',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                color: Theme.of(context).primaryColor,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
                fontFamily: 'Source Sans Pro',
              ),
            ),
            SizedBox(
              height: 20.0,
              child: Divider(
                color: Theme.of(context).primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (bCtx) => Developer()));
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Text(
                        "Developer",
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(
                        "Pedro Medeiros",
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: Text(
                        "Software Developer & Electrical Engineer",
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 12.0,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
