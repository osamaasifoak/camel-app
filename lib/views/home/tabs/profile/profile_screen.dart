import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _iandisGithubUrl = 'https://github.com/iandis';

class ProfileSectionScreen extends StatelessWidget {
  const ProfileSectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 60),
          CircleAvatar(
            radius: 60,
            backgroundImage: CachedNetworkImageProvider(
              '$_iandisGithubUrl.png',
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Iandi Santulus',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          GithubRepoLink(),
          SizedBox(height: 20),
          // -- hobies section --
          Text(
            'Hobbies',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: 30,
            child: Divider(
              color: Colors.blue,
              height: 2,
              thickness: 1,
            ),
          ),
          SizedBox(height: 10),
          Text('Chess'),
          SizedBox(height: 20),
          // -- favorite pets section --
          Text(
            'Favorite Pets',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: 60,
            child: Divider(
              color: Colors.blue,
              height: 2,
              thickness: 1,
            ),
          ),
          SizedBox(height: 10),
          Text('Cat'),
          SizedBox(height: 20),
          // -- political perspectives section --
          Text(
            'Political Perspectives',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: 90,
            child: Divider(
              color: Colors.blue,
              height: 2,
              thickness: 1,
            ),
          ),
          SizedBox(height: 10),
          Text('Neutral'),
          SizedBox(height: 20),

          // -- mbti personality type section --
          Text(
            'MBTI Personality Type',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: 110,
            child: Divider(
              color: Colors.blue,
              height: 2,
              thickness: 1,
            ),
          ),
          SizedBox(height: 10),
          Text('ENTP-A'),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class GithubRepoLink extends StatelessWidget {
  const GithubRepoLink({Key? key}) : super(key: key);

  Future<void> _openGithub() async {
    if (await canLaunch(_iandisGithubUrl)) {
      await launch(_iandisGithubUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openGithub,
      child: const Text(
        'github.com/iandis',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
