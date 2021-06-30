
import 'package:flutter/material.dart';

class MovieTagCard extends StatelessWidget{
  final String genreName;

  const MovieTagCard({
    Key? key, 
    required this.genreName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amberAccent[400],
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Text(
          genreName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[900],
          ),
        ),
      ),
    );
  }

}