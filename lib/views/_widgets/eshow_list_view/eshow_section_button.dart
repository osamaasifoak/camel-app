import 'package:flutter/material.dart';

class EShowSectionButton extends StatelessWidget {
  const EShowSectionButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        padding: const EdgeInsets.only(left: 16),
        width: MediaQuery.of(context).size.width - 16,
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            const CircleAvatar(
              radius: 10,
              backgroundColor: Color(0xFFE0E0E0),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
