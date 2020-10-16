import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:popular_movies/models/FavsModel.dart';
import 'package:popular_movies/models/data/Movie.dart';
import 'package:popular_movies/network/remote.dart';
import 'package:popular_movies/widgets/CircularCliperWidget.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final int id;

  const DetailsPage({Key key, this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState(id);
}

class _DetailsPageState extends State<DetailsPage> {
  final int id;
  Future<Movie> movie;

  _DetailsPageState(this.id);

  @override
  void initState() {
    super.initState();
    movie = Remote.fetchMovie(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        FutureBuilder<Movie>(
            future: movie,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? _ContentView(snapshot: snapshot)
                  : _LoadingView();
            }),
        Align(
          alignment: Alignment.lerp(
              Alignment.topLeft, Alignment.centerLeft, 0.2),
          child: _BackButtonWidget(),
        ),
        Align(
          alignment: Alignment.lerp(
              Alignment.topRight, Alignment.centerRight, 0.2),
          child: _FavoriteWidget(id: id),
        )
      ]),
    );
  }
}

class _ContentView extends StatelessWidget {
  final AsyncSnapshot<Movie> snapshot;

  const _ContentView({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = snapshot.data;

    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              transform: Matrix4.translationValues(0.0, -50.0, 0.0),
              child: ClipShadowPath(
                clipper: CircularClipper(),
                shadow: Shadow(blurRadius: 20.0),
                child: CachedNetworkImage(
                  imageUrl: Remote.image_url_large + movie.backdrop_path,
                  height: 400.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                movie.title.toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Text(
                movie.genres.toString(),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                '⭐ ${movie.vote_average}(${movie.vote_count})',
                style: TextStyle(fontSize: 25.0),
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Language',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        movie.original_language.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Release date',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        movie.release_date.replaceAll(new RegExp('-'), '.'),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Length',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        '${movie.runtime} min',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              Container(
                child: Text(
                  movie.overview,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Loading..."),
    );
  }
}

class _BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: 50,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

class _FavoriteWidget extends StatelessWidget {
  final num id;

  const _FavoriteWidget({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavesModel faves = Provider.of<FavesModel>(context);
    bool isFavorite = faves.getMovies().map((e) => e.id).toList().contains(id);
    IconData favoriteIcon = isFavorite ? Icons.favorite : Icons.favorite_border;
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: IconButton(
          icon: Icon(
            favoriteIcon,
            color: Colors.pink,
            size: 50,
          ),
          onPressed: isFavorite ? () => faves.remove(id) : () => faves.add(id)),
    );
  }
}
