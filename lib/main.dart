import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:popular_movies/models/MovieModel.dart';
import 'package:provider/provider.dart';

import 'models/FavsModel.dart';
import 'pages/SplashPage.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => MovieModel(),
          ),
          ChangeNotifierProxyProvider<MovieModel, FavesModel>(
              update: (_, movies, previousFaves) =>
                  FavesModel(movies, previousFaves)),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.black,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashPage(),
        ));
  }
}
