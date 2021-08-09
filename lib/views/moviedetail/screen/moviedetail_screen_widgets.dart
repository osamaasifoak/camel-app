part of '_moviedetail_screen.dart';

mixin _MovieDetailScreenWidgets on _MovieDetailScreenProps {
  Widget get movieDetail {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: [
            favIcon,
          ],
          elevation: 0,
          pinned: true,
          backgroundColor: Colors.grey[50],
          expandedHeight: MediaQuery.of(context).size.height * 0.67,
          flexibleSpace: appBarBgImage,
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              movieTitleAndYearOfRelease,
              movieTags,
              const SizedBox(height: 5),
              movieBackdropImage,
              movieRuntimeAndRating,
              movieOverview,
            ],
          ),
        ),
        movieReviewsSectionTitle,
        movieReviews,
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  Widget get favIcon {
    final currentState = _movieDetailCubit.state as MovieDetailLoaded;
    switch (currentState.isFav) {
      case true:

        ///if is already favorited by user
        ///return solid heart symbol
        return IconButton(
          icon: const Icon(Icons.favorite),
          color: Colors.pinkAccent[400],
          onPressed: () => _movieDetailCubit.setFav(fav: false),
        );
      default:
        //if not
        //return heart symbol outlined
        return IconButton(
          icon: const Icon(Icons.favorite_border),
          color: Colors.pinkAccent[400],
          onPressed: _movieDetailCubit.setFav,
        );
    }
  }

  FlexibleSpaceBar get appBarBgImage {
    final currentState = _movieDetailCubit.state as MovieDetailLoaded;
    final errorImage = Center(
      child: Icon(
        Icons.error_outline,
        size: 30,
        color: Theme.of(context).errorColor,
      ),
    );
    return FlexibleSpaceBar(
      // Taken from image poster
      background: currentState.movieDetail.imgUrlPosterOriginal != null
          ? CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: currentState.movieDetail.imgUrlPosterOriginal!,
              filterQuality: FilterQuality.high,
              errorWidget: (_, __, ___) => errorImage,
              fadeOutDuration: const Duration(milliseconds: 500),
            )
          : errorImage,
    );
  }

  Widget get movieTitleAndYearOfRelease {
    final currentState = _movieDetailCubit.state as MovieDetailLoaded;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: RichText(
        overflow: TextOverflow.fade,
        maxLines: 3,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito Sans',
            color: Colors.black87,
          ),
          children: [
            TextSpan(
              text: currentState.movieDetail.title,
            ),
            TextSpan(
              text: ' (${currentState.movieDetail.year})',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget get movieOverview {
    final currentState = _movieDetailCubit.state as MovieDetailLoaded;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        currentState.movieDetail.overview,
        style: const TextStyle(
          letterSpacing: 0.5,
          wordSpacing: 1.5,
        ),
      ),
    );
  }

  Widget get movieRuntimeAndRating {
    final currentState = _movieDetailCubit.state as MovieDetailLoaded;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: '${currentState.movieDetail.runtime} min.  |  ',
            ),
            TextSpan(
              text: '${currentState.movieDetail.rating}/10',
            ),
            TextSpan(
              text: ' (${currentState.movieDetail.voteCount} votes)',
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get movieBackdropImage {
    final currentState = _movieDetailCubit.state as MovieDetailLoaded;
    return currentState.movieDetail.imgUrlBackdropOriginal != null
        ? CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: currentState.movieDetail.imgUrlBackdropOriginal!,
          filterQuality: FilterQuality.high,
          errorWidget: (_, __, ___) => Center(
            child: Icon(
              Icons.error_outline,
              size: 30,
              color: Theme.of(context).errorColor,
            ),
          ),
          fadeOutDuration: const Duration(milliseconds: 500),
        )
        : const SizedBox();
  }

  Widget get movieTags {
    final currentState = _movieDetailCubit.state as MovieDetailLoaded;
    return SizedBox(
      height: currentState.movieDetail.genres.isNotEmpty ? 80 : 0,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.horizontal,
        itemCount: currentState.movieDetail.genres.length,
        itemBuilder: (_, i) {
          return EShowTagCard(
            tagName: currentState.movieDetail.genres[i].name,
          );
        },
      ),
    );
  }

  Widget get movieReviewsSectionTitle {
    final currentState = _movieDetailCubit.state as MovieDetailLoaded;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Reviews (${currentState.movieReviews.length})',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget get movieReviews {
    final currentState = _movieDetailCubit.state as MovieDetailLoaded;
    return EShowReviewsList(reviews: currentState.movieReviews);
  }
}
