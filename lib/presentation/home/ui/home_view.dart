import 'package:astronomy_gallery/domain/models/astronomy_picture_model.dart';
import 'package:astronomy_gallery/presentation/home/cubit/home_cubit.dart';
import 'package:astronomy_gallery/presentation/home/ui/items/astronomy_picture_list_item.dart';
import 'package:astronomy_gallery/presentation/apod_detail/screens/picture_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        builder: (context, state) {
          final HomeCubit cubit = context.read<HomeCubit>();
          switch (state.status) {
            case HomeStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case HomeStatus.error:
              List<AstronomyPictureModel> localAstronomyPictures =
                  state.astronomyPictures;
              if (localAstronomyPictures.isEmpty) {
                return RefreshIndicator(
                  onRefresh: cubit.getAstronomyPictures,
                  child: ListView(
                    children: const [
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
              List<AstronomyPictureModel> astronomyPictures =
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
        children: [
          Text(
            AppLocalizations.of(context)!.featuredPictures,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            flex: 1,
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
        itemBuilder: (context, index) {
          final picture = astronomyPictures[index];
          if (picture.mediaType == 'image' || picture.mediaType == 'gif') {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
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
    double height = size.height;
    double width = size.width;
    var path = Path();
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
