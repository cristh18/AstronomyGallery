import 'package:astronomy_gallery/data/datasource/remote/api/apod_api.dart';
import 'package:astronomy_gallery/data/repositories/apod_repository.dart';
import 'package:astronomy_gallery/domain/models/astronomy_picture_model.dart';
import 'package:astronomy_gallery/modules/home/widgets/astronomy_picture_list_item.dart';
import 'package:astronomy_gallery/modules/apod_detail/screens/picture_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<AstronomyPictureModel> astronomyPictures = getAstronomyPictures();

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
                'Explore',
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
      body: SingleChildScrollView(
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
                          text: 'Featured ',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: 'Pictures',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  for (final picture in astronomyPictures)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // builder: (context) => AstronomyPictureDetailScreen(movie: movie),
                            builder: (context) =>
                                PictureDetailScreen(astronomyPicture: picture),
                          ),
                        );
                      },
                      child: AstronomyPictureListItem(
                        title: picture.title,
                        imageUrl: picture.url,
                        information: '${picture.date} | ${picture.explanation}',
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<AstronomyPictureModel> getAstronomyPictures() {
    const apiKey = "DIJtrZ1BcoBUmv8BnNcoz67g1YeZaa9Zq8jkDnEU";
    // const apiKey = "sdsfsdf";
    final logger = Logger();
    final dio = Dio();
    final APODRepository apodRepository = APODRepository(apodApi: APODApi(dio));
    apodRepository.getApods(10, true, apiKey).then((value) {
      logger.i(value);
      return value;
    });
    return AstronomyPictureModel.astronomyPictures;
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
