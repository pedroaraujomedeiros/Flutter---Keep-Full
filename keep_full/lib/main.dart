import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './Widgets/widgets.dart';
import './Models/models.dart';
import './Blocs/blocs.dart';
import './Blocs/simple_bloc_delegate.dart';

void main() async {
  //It is required in Flutter v1.9.4+ before using any plugins if the code is executed before runApp.
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(BlocProvider(
    create: (context) => AuthenticationBloc(user: null)..add(AppStarted()),
    child: MyApp(),
  ));
}


class MyApp extends StatelessWidget {

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
      home: BlocBuilder<AuthenticationBloc,AuthenticationState>(
        condition: (prevState, currState) => currState != prevState,
        builder: (context, state){
          if(state is Uninitialized){
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60.0,
                height: 60.0,
              ),
            );
          }
          else if(state is Authenticated){
            return BlocProvider(
                create: (BuildContext context) => GroceryListBloc(GroceryList())..add(LoadFromDatabase()),
                child: HomePage(state.user),
            );
          }
          else if(state is Unauthenticated){
            return IntroScreen();
          }
          return Container();
        },
      ),

    );
  }
}

