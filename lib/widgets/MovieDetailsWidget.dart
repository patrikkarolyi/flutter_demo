import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies/pages/DetailsPage.dart';

class MovieDetailsWidget extends StatelessWidget {
  final num id;
  final String title;
  final num rating;
  final String imageUrl;

  const MovieDetailsWidget(
      {Key key, this.id, this.title, this.rating, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage(id: id)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(4),
        child: Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.fitWidth,
              imageUrl: imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  height: 55,
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '$rating ⭐',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
