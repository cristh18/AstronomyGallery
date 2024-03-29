import 'package:astronomy_gallery/data/repositories/apod_repository.dart';
import 'package:astronomy_gallery/domain/models/astronomy_picture_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.apodRepository) : super(HomeState());

  final APODRepository apodRepository;

  Future<void> getAstronomyPictures() async {
    const count = 50;
    const thumbs = true;
    String apiKey = dotenv.env['NASA_API_KEY'] ?? '';

    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final astronomyPictures =
          await apodRepository.getApods(count, thumbs, apiKey);
      final logger = Logger();
      for (var element in astronomyPictures) {
        logger.i(element.toString());
      }
      emit(state.copyWith(
        status: HomeStatus.success,
        astronomyPictures: astronomyPictures,
      ));
    } catch (e) {
      final localAstronomyPictures =
          await apodRepository.getLocalAstronomyPictures() ?? [];
      emit(state.copyWith(status: HomeStatus.error,
      astronomyPictures: localAstronomyPictures));
    }
  }
}
