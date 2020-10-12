import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies/pages/DetailsPage.dart';

class MovieDetailsWidget extends StatelessWidget {

  final num id;
  final String title;
  final num rating;
  final String imageUrl;

  const MovieDetailsWidget({Key key, this.id, this.title, this.rating, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage(id: id)),
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
              child: Text(title),
            ),
            Expanded(
              child: Row(
                children: [
                  Icon(Icons.star),
                  Expanded(child: Text(rating.toString())),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
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
