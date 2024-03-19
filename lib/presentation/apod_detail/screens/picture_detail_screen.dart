import 'package:flutter/material.dart';

import '../../../domain/models/astronomy_picture_model.dart';

class PictureDetailScreen extends StatelessWidget {
  const PictureDetailScreen({
    super.key,
    required this.astronomyPicture,
  });

  final AstronomyPictureModel astronomyPicture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ..._buildBackground(context),
          _buildMovieInformation(context),
        ],
      ),
    );
  }

  Positioned _buildMovieInformation(BuildContext context) {
    return Positioned(
      bottom: 150,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              astronomyPicture.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${astronomyPicture.date} | ${astronomyPicture.explanation}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBackground(context) {
    return <Widget>[
      Container(
        height: double.infinity,
        color: const Color(0xFF000B49),
      ),
      Image.network(
        astronomyPicture.url,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        fit: BoxFit.cover,
      ),
      const Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.transparent,
                Color(0xFF000B49),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: <double>[0.3, 0.5],
            ),
          ),
        ),
      ),
    ];
  }
}
