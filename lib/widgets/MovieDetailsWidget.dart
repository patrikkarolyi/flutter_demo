import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies/pages/DetailsPage.dart';

class MovieDetailsWidget extends StatelessWidget {
  final int index;

  const MovieDetailsWidget({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage()),
        );
      },
      child: Card(
        margin: EdgeInsets.all(5),
        elevation: 5,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              child: Text("The Last Samurai"),
            ),
            Expanded(
              child: Row(
                children: [
                  Icon(Icons.star),
                  Expanded(child: Text("$index")),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: CachedNetworkImage(
                imageUrl: "https://loremflickr.com/640/360",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            )
          ],
        ),
      ),
    );
  }
}
