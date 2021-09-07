import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '/core/helpers/screen_sizer.dart';

const _openGithub = __openGithub;
const _iandisGithubUrl = 'https://github.com/iandis';

Future<void> __openGithub() async {
  if (await canLaunch(_iandisGithubUrl)) {
    await launch(_iandisGithubUrl);
  }
}

class ProfileSectionScreen extends StatelessWidget {
  const ProfileSectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 60),
          GithubAvatar(),
          SizedBox(height: 20),
          FullName(onTap: _openGithub),
          GithubRepoLink(onTap: _openGithub),
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

class FullName extends StatelessWidget {
  const FullName({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: const Text(
        'Iandi Santulus',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}

class GithubAvatar extends StatefulWidget {
  const GithubAvatar({Key? key}) : super(key: key);

  static const avatarImageProvider = CachedNetworkImageProvider(
    '$_iandisGithubUrl.png',
    headers: {
      'Access-Control-Request-Method': 'GET',
      'Access-Control-Request-Headers': 'Content-Type, x-requested-with',
      'Origin': 'https://www.github.com'
    },
  );

  @override
  _GithubAvatarState createState() => _GithubAvatarState();
}

class _GithubAvatarState extends State<GithubAvatar> {
  void _showAvatarImage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionsBuilder: (_, startAnimation, __, page) {
          const begin = Offset(0, -1.0);
          const end = Offset.zero;
          const curve = Curves.fastLinearToSlowEaseIn;
          final tween = Tween<Offset>(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: startAnimation.drive(tween),
            child: FadeTransition(
              opacity: startAnimation,
              child: page,
            ),
          );
        },
        pageBuilder: (_, __, ___) {
          return const GithubAvatarFullScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showAvatarImage,
      child: const Hero(
        tag: _iandisGithubUrl,
        child: CircleAvatar(
          radius: 60,
          backgroundImage: GithubAvatar.avatarImageProvider,
        ),
      ),
    );
  }
}

class GithubAvatarFullScreen extends StatelessWidget {
  const GithubAvatarFullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      extendBodyBehindAppBar: true,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: ScreenSizer().currentHeight * 0.15 + kToolbarHeight / 2,
            bottom: 20,
          ),
          child: const Hero(
            tag: _iandisGithubUrl,
            child: Image(image: GithubAvatar.avatarImageProvider),
          ),
        ),
      ),
    );
  }
}

class GithubRepoLink extends StatelessWidget {
  const GithubRepoLink({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: const Text(
        'github.com/iandis',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
