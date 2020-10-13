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
    response = Remote.fetchTopRatedMovies();
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
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.black45,
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(50),
                      height: 50,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          this._sortPopupIsVisible = false;
                          setState(() {
                            response = Remote.fetchTopRatedMovies();
                          });
                        },
                        child: Card(
                          color: Colors.red,
                          child: Center(
                            child: Text("Sort my content by rating!",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(50),
                      height: 50,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          this._sortPopupIsVisible = false;
                          setState(() {
                            response = Remote.fetchPopularMovies();
                          });
                        },
                        child: Card(
                          color: Colors.red,
                          child: Center(
                            child: Text("Sort my content by popularity!",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
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
        expandedHeight: 500.0,
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
            title:  Text("Movies Flutter Application",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                )),
            background: Image.asset(
              "assets/uni.jpg",
              fit: BoxFit.cover,
            )),
      ),
    ];
  }
}
