
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:camelmovies/core/models/movie/movie.dart';

class MovieCard extends StatelessWidget{
  final Movie movie;
  final VoidCallback? onCardPressed;
  
  const MovieCard({Key? key, required this.movie, required this.onCardPressed}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // var rating = movie.rating! / 10;
    // if(rating <= 0.05) rating = 0.05;
    // var ratingBoxWidth = (MediaQuery.of(context).size.width / 5) * rating;
    // var ratingBoxHeight = 20.0;
    // var ratingBoxColor = Color.lerp(
    //   Colors.amber[800], 
    //   Colors.greenAccent[700],
    //   rating
    // );    
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      padding: const EdgeInsets.all(0),
      child: ElevatedButton(
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all<Color>(Colors.grey[50]!.withOpacity(0.3)),          
          elevation: MaterialStateProperty.all<double>(4.0),
          backgroundColor: MaterialStateProperty.all<Color?>(Colors.grey[50]),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black87),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
              if (states.contains(MaterialState.hovered))
                return Colors.grey[200];                
              if (states.contains(MaterialState.pressed) ||
                  states.contains(MaterialState.focused) )
                return Colors.grey[300];
              return null;
            }
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onCardPressed,
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            //leading image
            Flexible(
              flex: 0,
              child: Container(
                width: 80,
                height: 120,
                color: Colors.white70,
                child: movie.imgUrlPoster != null 
                ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: movie.imgUrlPosterThumb,
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeOutDuration: const Duration(milliseconds: 500),
                    filterQuality: FilterQuality.none,
                    memCacheHeight: 240,
                    memCacheWidth: 160,
                    errorWidget: (context, url, error) =>
                      Center(
                        child: Icon(
                          Icons.error_outline,
                          size: 24,
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                )
                : Center(
                    child: Icon(
                      Icons.error_outline,
                      size: 24,
                      color: Theme.of(context).errorColor,
                    ),
                ),
              )
              
            ),
            SizedBox(width: 10,), //separator
            //movie title
            Flexible(
              flex: 1,
              child: Column(    
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,        
                children: [
                  Text(
                    movie.title! + ' (' + movie.year! + ')',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito Sans'
                      ),
                  ),
                  const SizedBox(height: 2,),
                  Row(
                    children: [
                      //star + rating
                      // Container(
                      //   width: ratingBoxWidth,
                      //   height: ratingBoxHeight,
                      //   color: ratingBoxColor,
                      //   margin: const EdgeInsets.only(right: 5)                   
                      // ),
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.yellow[800],
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                          children: [
                            TextSpan(
                              text: (movie.rating?.toStringAsFixed(1) ?? '0.0'),
                            ),
                            TextSpan(
                              text: ' (' + movie.voteCount.toString() + ' votes)',
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ), 
            SizedBox(width: 10,), //separator
          ],
        ),
      ),
    );
  }

}

