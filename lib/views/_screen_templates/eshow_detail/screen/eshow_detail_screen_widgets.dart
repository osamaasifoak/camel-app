part of '_eshow_detail_screen.dart';

mixin _EShowDetailScreenWidgets on _EShowDetailScreenProps {
  Widget get eShowDetails {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          actions: <Widget>[
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
            children: <Widget>[
              eShowTitleAndReleaseDate,
              eShowTags,
              const SizedBox(height: 5),
              eShowBodyImage,
              eShowRuntimeAndRating,
              eShowOverview,
            ],
          ),
        ),
        eShowReviewsSectionTitle,
        eShowReviews,
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  Widget get favIcon {
    switch (currentCubitState.isFav) {
      case true:

        ///if is already favorited by user
        ///return solid heart symbol
        return IconButton(
          icon: const Icon(Icons.favorite),
          color: const Color(0xFFF50057), // Colors.pinkAccent[400]
          onPressed: () => _eShowDetailCubit.setFav(fav: false),
        );
      default:
        //if not
        //return heart symbol outlined
        return IconButton(
          icon: const Icon(Icons.favorite_border),
          color: const Color(0xFFF50057), // Colors.pinkAccent[400]
          onPressed: _eShowDetailCubit.setFav,
        );
    }
  }

  FlexibleSpaceBar get appBarBgImage {
    final String? imageUrl;

    // for long screens (mobile screens)
    // it's ScreenSizer().currentAspectRatio * 1.5 because the picture only takes
    // 67% of the screen height. Hence 1/0.67 = 3/2 = 1.5
    if (ScreenSizer().currentAspectRatio * 1.5 <= 1.0) {
      imageUrl = currentCubitState.eShowDetails!.imgUrlPosterOriginal;
    } else {
      // for large screens (web)
      imageUrl = currentCubitState.eShowDetails!.imgUrlBackdropOriginal;
    }
    final Widget image;
    if (imageUrl != null) {
      image = CachedNetworkImage(
        imageUrl: imageUrl,
        cacheManager: AppCacheManager(),
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => Center(
          child: Icon(
            Icons.error_outline,
            size: 30,
            color: Theme.of(context).errorColor,
          ),
        ),
        fadeInDuration: const Duration(milliseconds: 250),
        fadeOutDuration: const Duration(milliseconds: 250),
      );
    } else {
      image = Center(
        child: Icon(
          Icons.error_outline,
          size: 30,
          color: Theme.of(context).errorColor,
        ),
      );
    }
    return FlexibleSpaceBar(background: image);
  }

  Widget get eShowTitleAndReleaseDate {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            currentCubitState.eShowDetails!.title,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            _dateFormatter.format(DateTime.parse(currentCubitState.eShowDetails!.releaseDate)),
            style: const TextStyle(
              color: Color(0xFF616161),
            ),
          ),
        ],
      ),
    );
  }

  Widget get eShowOverview {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        currentCubitState.eShowDetails!.overview,
        style: const TextStyle(
          letterSpacing: 0.5,
          wordSpacing: 1.5,
        ),
      ),
    );
  }

  Widget get eShowRuntimeAndRating {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          SelectableText(
            '${currentCubitState.eShowDetails!.runtime} min.  |  ',
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          SelectableText(
            '${currentCubitState.eShowDetails!.rating}/10',
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          SelectableText(
            ' (${currentCubitState.eShowDetails!.voteCount} votes)',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget get eShowBodyImage {
    final String? imageUrl;
    // it's ScreenSizer().currentAspectRatio * 1.5 because app bar picture only takes
    // 67% of the screen height. Hence 1/0.67 = 3/2 = 1.5
    final double currentAspectRatio = ScreenSizer().currentAspectRatio * 1.5;

    // for long screens (mobile screens)
    if (currentAspectRatio <= 1.0) {
      imageUrl = currentCubitState.eShowDetails!.imgUrlBackdropOriginal;
    } else {
      // for large screens (web)
      imageUrl = currentCubitState.eShowDetails!.imgUrlPosterOriginal;
    }
    Widget image;
    if (imageUrl != null) {
      image = CachedNetworkImage(
        imageUrl: imageUrl,
        cacheManager: AppCacheManager(),
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => Center(
          child: Icon(
            Icons.error_outline,
            size: 30,
            color: Theme.of(context).errorColor,
          ),
        ),
        fadeInDuration: const Duration(milliseconds: 250),
        fadeOutDuration: const Duration(milliseconds: 250),
      );
      // if it's on the web, we don't want the picture to cover most of the
      // screen, so we need to make it scrollable instead

      if (currentAspectRatio > 1.0) {
        image = Container(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: ScreenSizer().currentWidth,
          height: ScreenSizer().currentHeight * 0.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: SingleChildScrollView(child: image),
        );
      }
    } else {
      image = Center(
        child: Icon(
          Icons.error_outline,
          size: 30,
          color: Theme.of(context).errorColor,
        ),
      );
    }
    return image;
  }

  Widget get eShowTags {
    return SizedBox(
      height: currentCubitState.eShowDetails!.genres.isNotEmpty ? 80 : 0,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.horizontal,
        itemCount: currentCubitState.eShowDetails!.genres.length,
        itemBuilder: (_, int i) {
          return EShowTagCard(
            tagName: currentCubitState.eShowDetails!.genres[i].name,
          );
        },
      ),
    );
  }

  Widget get eShowReviewsSectionTitle {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Reviews (${currentCubitState.eShowReviews.length})',
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

  Widget get eShowReviews {
    return EShowReviewsList(reviews: currentCubitState.eShowReviews);
  }
}
