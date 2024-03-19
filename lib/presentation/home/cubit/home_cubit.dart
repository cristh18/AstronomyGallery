import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

import '../../../data/repositories/apod_repository.dart';
import '../../../domain/models/astronomy_picture_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.apodRepository) : super(const HomeState());

  final APODRepository apodRepository;

  Future<void> getAstronomyPictures() async {
    const int count = 50;
    const bool thumbs = true;
    final String apiKey = dotenv.env['NASA_API_KEY'] ?? '';

    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final List<AstronomyPictureModel> astronomyPictures =
          await apodRepository.getApods(count, thumbs, apiKey);
      final Logger logger = Logger();
      for (final AstronomyPictureModel element in astronomyPictures) {
        logger.i(element.toString());
      }
      emit(state.copyWith(
        status: HomeStatus.success,
        astronomyPictures: astronomyPictures,
      ));
    } catch (e) {
      final List<AstronomyPictureModel> localAstronomyPictures =
          await apodRepository.getLocalAstronomyPictures() ?? <AstronomyPictureModel>[];
      emit(state.copyWith(status: HomeStatus.error,
      astronomyPictures: localAstronomyPictures));
    }
  }
}
