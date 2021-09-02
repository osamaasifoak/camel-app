# **caMel ~~Movies~~**  

[![Codemagic build status](https://api.codemagic.io/apps/60830e9e395dbc47ceab31a7/60830e9e395dbc47ceab31a6/status_badge.svg)](https://codemagic.io/apps/60830e9e395dbc47ceab31a7/60830e9e395dbc47ceab31a6/latest_build) [![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

An app capable of searching, favoriting and showing list of movies and tv shows, which are divided by a few sections each. The movies list consists of **Popular**, **Now Playing**, and **Upcoming**, and the tv shows list consists of **Popular** and **On The Air**. This app consumes [TMDB's API](https://www.themoviedb.org/documentation/api).

### Architecture: BLoC State Management + Repository Pattern
This app utilizes the **bloc** library for separating its business layer and presentation layer, and for separating data layer, it implements the repository pattern.

### Libraries used:
- **[animated_text_kit](https://pub.dev/packages/animated_text_kit)**
- **[cached_network_image](https://pub.dev/packages/cached_network_image)** 
- **[flutter_bloc](https://pub.dev/packages/flutter_bloc)** 
- **[get_it](https://pub.dev/packages/get_it)**
- **[postor](https://pub.dev/packages/postor)**
- **[rxdart](https://pub.dev/packages/rxdart)**
- **[sqflite](https://pub.dev/packages/sqflite)** 
- etc.

### How to use:
1.  First of all, make sure you have **Flutter 2.2.3** and **Dart 2.13.4** installed. 
2.  After that, also make sure you have a [TMDB](https://themoviedb.org) API key. If you don't have the account, create one [here](https://www.themoviedb.org/signup). Don't forget to request the API key, too.
3.  After all of the above steps, now lets create the **apikey.txt** file in **/assets/apikey.txt** and put your key there.

Done! You can run the app now!

If you're curious of how the app looks like, here are the  quick previews of the app:  
<img src="/images/1.gif" width="180" height="392">   <img src="/images/2.gif" width="180" height="392">   <img src="/images/3.gif" width="180" height="392">  <img src="/images/4.gif" width="180" height="392">  <img src="/images/5.gif" width="180" height="392">   <img src="/images/6.gif" width="180" height="392">   <img src="/images/7.gif" width="180" height="392">   <img src="/images/8.gif" width="180" height="392">

### My journeys with this project:
1.  Initial version consisted only <ins>the app icon, a splash screen, a list of now playing and upcoming movies list, movie detail screen, and a list of favorited movies</ins>. The movies list screen was the home screen with top TabBar for navigating between now playing and upcoming. The initial version had a name of **I's Movies Catalogue** and its folder structure was **folder-by-layer**.

2.  Fixed a bug on list screens where the scroll position resets every time navigating between screens.

3.  Deleted the old repository and changed the app name to **caMel**. This was intended for refactoring the entire folder structure to a mix of **folder-by-layer** and **folder-by-features**. The reason behind was, after I read so many articles and forums (e.g. medium, stackexchange, stackoverflow, reddit, etc) about *best practices* of organizing folder structure for projects that are meant for long-term, are either **folder-by-features** or mixes between **folder-by-type** and **folder-by-features** or **folder-by-layer** and **folder-by-features** or any form of it. Another intention was to try my best enforcing **SOLID principles** on the project.

4.  Introduced **ErrorHandler** and **NetworkService**. ErrorHandler was created to reduce duplicates on both try-catching errors and throwing errors from the data repositories. NetworkService was a wrapper around Dart's http package with additional mechanisms such as network timeout limit and retry policy.

5.  **TabBar** removed, introduced **BottomNavigationBar** as a replacement.

6.  Added abstractions to service classes and repository classes.

7.  Services and repositories were now injected through **GetIt** instead of **RepositoryProvider**.

8.  Added favorite movies counter badge. This was possible thanks to a StreamController I added to the FavMoviesRepository. The counter badge will always update everytime a movie is added/removed from favorites.

9.  Introduced **lint** for enforcing [Dart's effective-style](https://dart.dev/guides/language/effective-dart/style).

10. Introduced the *circular page reveal* transition animation when navigating to favorite movies and when splash screen closes. Credits to [Alexander Zhdanov](https://github.com/qwert2603) for making this possible. See his work that I copied from [here](https://github.com/qwert2603/circular_reveal_animation/blob/master/lib/src/circular_reveal_clipper.dart).

11. Introduced **TV Shows**, **Favorite TV Shows**, and **Profile** screens. This, at the same time, introduced sections page views as the home screen. The list screens were now moved to different separated screens.

12. Added fading animation to favorite count badge when switching between sections page views.

13. Introduced **Search Screen** for searching both movies and tv shows.

14. Added animation to home title bar using the **animated_text_kit**

15. Introduced a new transition animation to improve the circular page reveal transition animation. The new transition aligns the circular page reveal based on user's last interaction on the screen. This is now the new transition animation for when navigating to details screen. You can see it on preview 4 & 5 above.

16. Merged repositories, widgets, and screens into single reusable components. This is intended to reduce duplications of code by creating base classes, reusable widgets and screen templates.