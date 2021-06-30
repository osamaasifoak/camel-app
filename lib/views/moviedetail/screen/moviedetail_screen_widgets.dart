part of '_moviedetail_screen.dart';

mixin _MovieDetailScreenWidgets on _MovieDetailScreenProps{
  Widget movieDetail(){
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: [
            favIcon(),
          ],
          floating: true,
          elevation: 0.7,
          shadowColor: Colors.grey[100],
          backgroundColor: Colors.grey[50],
          expandedHeight: screenHeight / 1.5,
          flexibleSpace: appBarBgImage(),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              movieTitleAndYearOfRelease(),

              movieTags(),

              const SizedBox(height: 5), //separator

              movieBackdropImage(),

              movieRuntimeAndRating(),

              movieOverview(),

              const SizedBox(height: 40), //bottom separator
            ],
          ),
        ),
      ],
    );
  }

  Widget favIcon() {
    switch (movieDetailCubit.state.isFav) {
      case true:

        ///if is already favorited by user
        ///return solid heart symbol
        return IconButton(
          icon: Icon(Icons.favorite),
          color: Colors.pinkAccent[400],
          onPressed: () => movieDetailCubit.setFav(false),
        );
      default:
        //if not
        //return heart symbol outlined
        return IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.pinkAccent[400],
          onPressed: movieDetailCubit.setFav,
        );
    }
  }

  FlexibleSpaceBar appBarBgImage() {
    return FlexibleSpaceBar(
      ///Taken from image poster
      background: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: movieDetailCubit.state.movieDetail.imgUrlPosterOriginal,
        errorWidget: (context, url, error) => Container(
          height: screenHeight / 1.5,
          child: Icon(
            Icons.error_outline,
            size: 30,
            color: Theme.of(context).errorColor,
          ),
        ),
        fadeInDuration: const Duration(milliseconds: 500),
        fadeOutDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  Padding movieTitleAndYearOfRelease() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: RichText(
        overflow: TextOverflow.fade,
        maxLines: 3,
        text: TextSpan(
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito Sans',
            color: Colors.black87,
          ),
          children: [
            TextSpan(
              text: movieDetailCubit.state.movieDetail.title,
            ),
            TextSpan(
              text: ' (' + movieDetailCubit.state.movieDetail.year! + ')',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Padding movieOverview() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        movieDetailCubit.state.movieDetail.overview!,
        style: const TextStyle(
          letterSpacing: 0.5,
          wordSpacing: 1.5,
        ),
      ),
    );
  }

  Padding movieRuntimeAndRating() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: movieDetailCubit.state.movieDetail.runtime.toString() +
                  ' min.  |  ',
            ),
            TextSpan(
              text:
                  movieDetailCubit.state.movieDetail.rating.toString() + '/10',
            ),
            TextSpan(
              text: ' (' +
                  movieDetailCubit.state.movieDetail.voteCount.toString() +
                  ' votes)',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding movieBackdropImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: movieDetailCubit.state.movieDetail.imgUrlBackdropOriginal,
          fadeInDuration: const Duration(milliseconds: 500),
          fadeOutDuration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }

  Container movieTags() {
    return Container(
      height: movieDetailCubit.state.movieDetail.genres!.length > 0 ? 60 : 0,
      child: ListView.builder(
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.horizontal,
        itemCount: movieDetailCubit.state.movieDetail.genres!.length,
        itemBuilder: (context, i) {
          return MovieTagCard(
              genreName:
                  movieDetailCubit.state.movieDetail.genres![i].genreName ??
                      'Genre');
        },
      ),
    );
  }

}
