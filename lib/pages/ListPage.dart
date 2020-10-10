import 'package:flutter/material.dart';

import 'DetailsPage.dart';
import 'FavoritePage.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _sortPopupIsVisible = false;
  List<MaterialColor> gridColors = [
    Colors.red,
    Colors.deepPurple,
    Colors.green,
    Colors.deepOrange,
    Colors.red,
    Colors.deepPurple,
    Colors.green,
    Colors.deepOrange,
    Colors.red,
    Colors.deepPurple,
    Colors.green,
    Colors.deepOrange
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App name"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
            },
            icon: Icon(Icons.star),
          ),
          IconButton(
            onPressed: () {
              _openSortPopup(context);
              this._sortPopupIsVisible = true;
            },
            icon: Icon(Icons.sort),
          ),
        ],
      ),
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 8,
          itemBuilder: (BuildContext context, int x) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsPage()),
                );
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: gridColors[x],
                ),
              ),
            );
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
