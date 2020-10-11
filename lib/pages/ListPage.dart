import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App name"),
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
              this._sortPopupIsVisible = true;
            },
          ),
        ],
      ),
      body: GridView.builder(
          itemCount: 100,
          physics: BouncingScrollPhysics(),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int x) {
            return MovieDetailsWidget(index: x);
          }),
    );
  }

  //Show sort popup
  void _openSortPopup(BuildContext context) {
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
}
