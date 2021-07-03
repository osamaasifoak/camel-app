part of '_home_screen.dart';

mixin _HomeScreenWidgets on _HomeScreenProps {
  
  List<Widget> moviePages() => [ 
    NowPlayingScreen(scrollController: nowPlayingScrollController), 
    UpcomingScreen(scrollController: upcomingScrollController),
  ];

  List<BottomNavigationBarItem> bottomNavItems() => const [
    BottomNavigationBarItem(
      icon: Icon(Icons.smart_display_outlined),
      activeIcon: Icon(Icons.smart_display),
      label: 'Now Playing',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.upcoming_outlined),
      activeIcon: Icon(Icons.upcoming),
      label: 'Upcoming',
    ),
  ];

  // Widget tabs() {
  //   return Column(
  //     children: [
  //       TabBar(
  //         controller: tabController,
  //         labelColor: Colors.lightBlueAccent[700],
  //         indicatorColor: Colors.lightBlue[900],
  //         unselectedLabelColor: Colors.grey,
  //         // onTap: tabBarTapped,
  //         tabs: const [
  //           Tab(
  //             text: 'Now Playing',
  //           ),
  //           Tab(
  //             text: 'Upcoming',
  //           )
  //         ]),
  //       Expanded(
  //         child: TabBarView(
  //           controller: tabController,
  //           physics: const NeverScrollableScrollPhysics(),
  //           children: const [
  //             NowPlayingScreen(),
  //             UpcomingScreen(),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget favIcon() {
    return IconButton(
      icon: const Icon(Icons.favorite_border),
      color: Colors.grey[900],
      onPressed: loadFavMovies,
    );
  }
}