import 'package:astronomy_gallery/data/repositories/apod_repository.dart';
import 'package:astronomy_gallery/domain/models/astronomy_picture_model.dart';
import 'package:bloc/bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.apodRepository) : super(HomeState());

  final APODRepository apodRepository;

  Future<void> getAstronomyPictures() async {
    const count = 10;
    const thumbs = true;
    const apiKey = "DIJtrZ1BcoBUmv8BnNcoz67g1YeZaa9Zq8jkDnEU";
    // const apiKey = "sdsfsdf";

    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final astronomyPictures = await apodRepository.getApods(count, thumbs, apiKey);
      emit(state.copyWith(
        status: HomeStatus.success,
        astronomyPictures: astronomyPictures,
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error));
    }
  }
}
