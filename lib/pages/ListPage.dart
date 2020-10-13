import 'package:flutter/material.dart';
import 'package:popular_movies/models/Movie.dart';
import 'package:popular_movies/models/Response.dart';
import 'package:popular_movies/network/remote.dart';
import 'package:popular_movies/widgets/MovieDetailsWidget.dart';

import 'FavoritePage.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _sortPopupIsVisible = false;

  Future<Response> response;

  @override
  void initState() {
    super.initState();
    response = Remote.fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return _getMoviesAppBar();
        },
        body: FutureBuilder<Response>(
            future: response,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? _getMoviesView(snapshot.data.results)
                  : _getEmptyMoviesView();
            }),
      ),
    );
  }

  //Show sort popup
  void _openSortPopup(BuildContext context) {
    this._sortPopupIsVisible = true;
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          this._sortPopupIsVisible = false;
        });
      },
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hello!"),
            content: Text("Please sort your content!"),
            actions: [
              okButton,
            ],
            elevation: 5,
          );
        });
  }

  Widget _getMoviesView(List<Movie> movies) {
    return Container(
      color: Colors.black,
      child: GridView.builder(
          itemCount: movies.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (BuildContext context, int index) {
            Movie movie = movies[index];
            return MovieDetailsWidget(
              id: movie.id,
              rating: movie.vote_average,
              title: movie.title,
              imageUrl: Remote.image_url_small + movie.poster_path,
            );
          }),
    );
  }

  Center _getEmptyMoviesView() {
    return Center(
      child: Text("No content."),
    );
  }

  List<Widget> _getMoviesAppBar() {
    return [
      SliverAppBar(
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        actions: [
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _openSortPopup(context);
            },
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                color: Colors.black,
                elevation: 5,
                child: Text("Movies Flutter Application",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
              ),
            ),
            background: Image.asset(
              "assets/uni.jpg",
              fit: BoxFit.cover,
            )),
      ),
    ];
  }
}
