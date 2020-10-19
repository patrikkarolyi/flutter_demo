import 'package:flutter/material.dart';
import 'package:popular_movies/models/data/movie.dart';
import 'package:popular_movies/models/favs_model.dart';
import 'package:popular_movies/network/remote.dart';
import 'package:popular_movies/widgets/movie_details_widget.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    List<Movie> favorites = Provider.of<FavesModel>(context).getMovies();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: favorites != null && favorites.length > 0
            ? _ContentView(favorites: favorites)
            : _EmptyView());
  }
}

class _ContentView extends StatelessWidget {
  final List<Movie> favorites;

  const _ContentView({Key key, this.favorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: GridView.builder(
          itemCount: favorites.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (BuildContext context, int index) {
            Movie movie = favorites[index];
            return MovieDetailsWidget(
                id: movie.id,
                rating: movie.vote_average,
                title: movie.title,
                imageUrl: Remote.image_url_small + movie.poster_path,
                isFavorite: true);
          }),
    );
  }
}

class _EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("No content."),
    );
  }
}
