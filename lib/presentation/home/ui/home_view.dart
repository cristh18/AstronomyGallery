import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/models/astronomy_picture_model.dart';
import '../../apod_detail/screens/picture_detail_screen.dart';
import '../cubit/home_cubit.dart';
import 'items/astronomy_picture_list_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _CustomClipper(),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF000B49),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.explore,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, HomeState state) {
          final HomeCubit cubit = context.read<HomeCubit>();
          switch (state.status) {
            case HomeStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case HomeStatus.error:
              final List<AstronomyPictureModel> localAstronomyPictures =
                  state.astronomyPictures;
              if (localAstronomyPictures.isEmpty) {
                return RefreshIndicator(
                  onRefresh: cubit.getAstronomyPictures,
                  child: ListView(
                    children: const <Widget>[
                      Center(
                        child: Text('Error'),
                      ),
                    ],
                  ),
                );
              } else {
                return _BuildAPODBodyWidget(
                    astronomyPictures: localAstronomyPictures, cubit: cubit);
              }
            case HomeStatus.success:
              final List<AstronomyPictureModel> astronomyPictures =
                  state.astronomyPictures;
              return _BuildAPODBodyWidget(
                  astronomyPictures: astronomyPictures, cubit: cubit);
          }
        },
      ),
    );
  }
}

class _BuildAPODBodyWidget extends StatelessWidget {
  const _BuildAPODBodyWidget({
    required this.astronomyPictures,
    required this.cubit,
  });
  final List<AstronomyPictureModel> astronomyPictures;
  final HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 150,
        bottom: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            AppLocalizations.of(context)!.featuredPictures,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: __BuildListWidget(
              astronomyPictures: astronomyPictures,
              onRefresh: cubit.getAstronomyPictures,
            ),
          ),
        ],
      ),
    );
  }
}

class __BuildListWidget extends StatelessWidget {
  const __BuildListWidget({
    required this.astronomyPictures,
    required this.onRefresh,
  });
  final List<AstronomyPictureModel> astronomyPictures;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 20),
        shrinkWrap: true,
        itemCount: astronomyPictures.length,
        itemBuilder: (BuildContext context, int index) {
          final AstronomyPictureModel picture = astronomyPictures[index];
          if (picture.mediaType == 'image' || picture.mediaType == 'gif') {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PictureDetailScreen(astronomyPicture: picture),
                  ),
                );
              },
              child: AstronomyPictureListItem(
                title: picture.title,
                imageUrl: picture.url,
                information: '${picture.date} | ${picture.explanation}',
                mediaType: picture.mediaType,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double height = size.height;
    final double width = size.width;
    final Path path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
