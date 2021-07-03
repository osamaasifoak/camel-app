
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:camelmovies/core/models/movie/movie.dart';

class MovieCard extends StatelessWidget{
  final Movie movie;
  final VoidCallback? onCardPressed;
  final ButtonStyle? style;
  
  const MovieCard({
    Key? key, 
    required this.movie, 
    required this.onCardPressed,
    this.style}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: style ?? ElevatedButton.styleFrom(
          shadowColor: Colors.grey[50]?.withOpacity(0.3),
          elevation: 4.0,
          primary: Colors.grey[50],
          onPrimary: Colors.black87,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
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
                    cacheKey: movie.id.toString(),
                    fit: BoxFit.cover,
                    imageUrl: movie.imgUrlPosterThumb,
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeOutDuration: const Duration(milliseconds: 500),
                    filterQuality: FilterQuality.none,
                    memCacheHeight: 240,
                    memCacheWidth: 160,
                    errorWidget: (_, __, ___) =>
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
            const SizedBox(width: 10,), //separator
            //movie title
            Flexible(
              flex: 1,
              child: Column(    
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,        
                children: [
                  Text(
                    movie.title! + ' (${movie.year ?? 'XXXX'})',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito Sans'
                      ),
                  ),
                  const SizedBox(height: 2,),
                  Row(
                    children: [
                      //star + rating
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.yellow[800],
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black87,
                          ),
                          children: [
                            TextSpan(
                              text: (movie.rating?.toStringAsFixed(1) ?? '0.0'),
                            ),
                            TextSpan(
                              text: ' (${movie.voteCount.toString()} votes)',
                              style: const TextStyle(
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
            const SizedBox(width: 10,), //separator
          ],
        ),
      ),
    );
  }

}

