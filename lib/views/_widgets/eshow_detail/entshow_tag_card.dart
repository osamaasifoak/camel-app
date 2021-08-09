
import 'package:flutter/material.dart';

class EShowTagCard extends StatelessWidget{
  final String tagName;

  const EShowTagCard({
    Key? key, 
    required this.tagName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amberAccent[400],
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Text(
          tagName,
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