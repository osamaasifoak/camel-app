part of '_tvshowdetail_screen.dart';

mixin _TVShowDetailScreenWidgets on _TVShowDetailScreenProps {
  Widget get tvShowDetail {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: [
            favIcon,
          ],
          pinned: true,
          elevation: 0,
          backgroundColor: Colors.grey[50],
          expandedHeight: MediaQuery.of(context).size.height * 0.67,
          flexibleSpace: appBarBgImage,
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              tvShowTitle,
              tvShowGenres,
              const SizedBox(height: 5),
              tvShowBackdropImage,
              tvShowRuntimeAndRating,
              tvShowOverview,
            ],
          ),
        ),
        tvShowReviewsSectionTitle,
        tvShowReviews,
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  Widget get favIcon {
    final currentState = _tvShowDetailCubit.state as TVShowDetailLoaded;
    switch (currentState.isFavTV) {
      case true:

        ///if is already favorited by user
        ///return solid heart symbol
        return IconButton(
          icon: const Icon(Icons.favorite),
          color: Colors.pinkAccent[400],
          onPressed: () => _tvShowDetailCubit.setFav(fav: false),
        );
      default:
        //if not
        //return heart symbol outlined
        return IconButton(
          icon: const Icon(Icons.favorite_border),
          color: Colors.pinkAccent[400],
          onPressed: _tvShowDetailCubit.setFav,
        );
    }
  }

  FlexibleSpaceBar get appBarBgImage {
    final currentState = _tvShowDetailCubit.state as TVShowDetailLoaded;
    final errorImage = Center(
      child: Icon(
        Icons.error_outline,
        size: 30,
        color: Theme.of(context).errorColor,
      ),
    );
    return FlexibleSpaceBar(
      ///Taken from image poster
      background: currentState.tvShowDetail.imgUrlPosterOriginal != null
          ? CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: currentState.tvShowDetail.imgUrlPosterOriginal!,
              filterQuality: FilterQuality.high,
              errorWidget: (_, __, ___) => errorImage,
              fadeOutDuration: const Duration(milliseconds: 500),
            )
          : errorImage,
    );
  }

  Widget get tvShowTitle {
    final currentState = _tvShowDetailCubit.state as TVShowDetailLoaded;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Text(
        currentState.tvShowDetail.title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito Sans',
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget get tvShowOverview {
    final currentState = _tvShowDetailCubit.state as TVShowDetailLoaded;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        currentState.tvShowDetail.overview,
        style: const TextStyle(
          letterSpacing: 0.5,
          wordSpacing: 1.5,
        ),
      ),
    );
  }

  Widget get tvShowRuntimeAndRating {
    final tvShowDetail = (_tvShowDetailCubit.state as TVShowDetailLoaded).tvShowDetail;
    final String tvShowRating;
    if ((tvShowDetail.rating * 10) % 10 == 0) {
      tvShowRating = tvShowDetail.rating.toStringAsFixed(0);
    } else {
      tvShowRating = tvShowDetail.rating.toString();
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: '${tvShowDetail.runtime.isNotEmpty ? tvShowDetail.runtime.first : '--'} min.  |  ',
            ),
            TextSpan(
              text: '$tvShowRating/10',
            ),
            TextSpan(
              text: ' (${tvShowDetail.voteCount} votes)',
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

  Widget get tvShowBackdropImage {
    final currentState = _tvShowDetailCubit.state as TVShowDetailLoaded;
    return currentState.tvShowDetail.imgUrlBackdropOriginal != null
        ? CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: currentState.tvShowDetail.imgUrlBackdropOriginal!,
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

  Widget get tvShowGenres {
    final currentState = _tvShowDetailCubit.state as TVShowDetailLoaded;
    return SizedBox(
      height: currentState.tvShowDetail.genres.isNotEmpty ? 80 : 0,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.horizontal,
        itemCount: currentState.tvShowDetail.genres.length,
        itemBuilder: (_, i) {
          return EShowTagCard(
            tagName: currentState.tvShowDetail.genres[i].name,
          );
        },
      ),
    );
  }

  Widget get tvShowReviewsSectionTitle {
    final currentState = _tvShowDetailCubit.state as TVShowDetailLoaded;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Reviews (${currentState.tvShowReviews.length})',
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

  Widget get tvShowReviews {
    final currentState = _tvShowDetailCubit.state as TVShowDetailLoaded;
    return EShowReviewsList(reviews: currentState.tvShowReviews);
  }
}
