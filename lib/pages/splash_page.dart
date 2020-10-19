import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:popular_movies/models/db/db.dart';
import 'package:popular_movies/pages/list_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("Welcome",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            )),
      ),
    );
  }



  @override
  void initState() {
    super.initState();
    final injector = GetIt.instance;
    final Db db = injector();

    db.initDb().whenComplete(() {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ListPage()));
    });
  }
}
