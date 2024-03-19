import 'dart:io';

// import 'package:astronomy_gallery/data/datasource/remote/api/apod_api.dart';
// import 'package:astronomy_gallery/data/repositories/apod_repository.dart';
import 'package:astronomy_gallery/domain/models/astronomy_picture_model.dart';
import 'package:astronomy_gallery/presentation/home/cubit/home_cubit.dart';
// import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'home_cubit_test.mocks.dart';

// class MockHomeState extends Mock implements HomeState {}

void main() {
  final mockRepository = MockAPODRepository();

  setUpAll(() async {
    await dotenv.load();
    var path = Directory.current.path;
    Hive.init(path);
  });

  setUp(() {
    when(mockRepository.getApods(1, true, dotenv.env['NASA_API_KEY']!))
        .thenAnswer((_) async => <AstronomyPictureModel>[
              AstronomyPictureModel(
                title: 'The Sea Beast',
                explanation:
                    'This image is a close-up of the head of the Seagull Nebula. It is a composite of images taken in the light of ionized hydrogen (H-alpha) and oxygen (OIII).',
                date: '2022-10-01',
                url: 'https://apod.nasa.gov/apod/image/9612/ngc2440_hst2.jpg',
                hdurl:
                    'https://apod.nasa.gov/apod/image/9612/ngc2440_hst2_big.jpg',
                mediaType: 'image',
                serviceVersion: 'v1',
              )
            ]);
  });

  group('HomeCubit', () {
    blocTest('Fetch data',
        build: () => HomeCubit(mockRepository),
        act: (HomeCubit cubit) => cubit.getAstronomyPictures(),
        expect: () => <HomeState>[
              HomeState(status: HomeStatus.loading),
              HomeState(
                  status: HomeStatus.success,
                  astronomyPictures: AstronomyPictureModel.astronomyPictures),
            ]);
  });
}
