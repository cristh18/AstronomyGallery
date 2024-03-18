import 'package:astronomy_gallery/domain/models/astronomy_picture_model.dart';
import 'package:astronomy_gallery/presentation/home/cubit/home_cubit.dart';
import 'package:astronomy_gallery/presentation/home/ui/items/astronomy_picture_list_item.dart';
import 'package:astronomy_gallery/presentation/apod_detail/screens/picture_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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
          switch (state.status) {
            case HomeStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case HomeStatus.error:
              return const Center(
                child: Text('Error'),
              );
            case HomeStatus.success:
              List<AstronomyPictureModel> astronomyPictures =
                  state.astronomyPictures;
              final logger = Logger();
              for (var element in astronomyPictures) {
                logger.i(element.toString());
              }
              return getAPODBodyView(context, astronomyPictures);
          }
        },
      ),
    );
  }

  SingleChildScrollView getAPODBodyView(
      BuildContext context, List<AstronomyPictureModel> astronomyPictures) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 150,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.titleLarge,
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.featured,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.pictures,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                for (final picture in astronomyPictures)
                  if (picture.mediaType == 'image' ||
                      picture.mediaType == 'gif')
                    InkWell(
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
                    )
              ],
            ),
          ),
        ],
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
