import 'package:flutter/material.dart';

import '/core/constants/app_colors.dart';

class EShowTagCard extends StatelessWidget {
  const EShowTagCard({
    Key? key,
    required this.tagName,
  }) : super(key: key);

  final String tagName;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.of(context).secondaryColor,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Text(
          tagName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: AppColors.of(context).whiteColor,
          ),
        ),
      ),
    );
  }
}
