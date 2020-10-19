import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:popular_movies/models/movie_model.dart';
import 'package:provider/provider.dart';

import 'di/service.dart';
import 'models/favs_model.dart';
import 'pages/splash_page.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          title: 'Movie Flutter Application',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.black,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashPage(),
        ));
  }
}
