part of '_home_screen.dart';

mixin _HomeScreenWidgets on _HomeScreenProps {
  
  Widget tabs() {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          labelColor: Colors.lightBlueAccent[700],
          indicatorColor: Colors.lightBlue[900],
          unselectedLabelColor: Colors.grey,
          // onTap: tabBarTapped,
          tabs: const [
            Tab(
              text: 'Now Playing',
            ),
            Tab(
              text: 'Upcoming',
            )
          ]),
        Expanded(
          child: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const NowPlayingScreen(),
              const UpcomingScreen(),
            ],
          ),
        ),
      ],
    );
  }

  Widget favIcon() {
    return IconButton(
      icon: Icon(Icons.favorite_border),
      color: Colors.grey[900],
      onPressed: loadFavMovies,
    );
  }
}