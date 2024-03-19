part of 'home_cubit.dart';

enum HomeStatus {
  loading,
  success,
  error,
}

class HomeState extends Equatable {
  HomeState({
    this.status = HomeStatus.loading,
    this.astronomyPictures = const <AstronomyPictureModel>[],
  });

  final HomeStatus status;
  final List<AstronomyPictureModel> astronomyPictures;

  HomeState copyWith({
    HomeStatus? status,
    List<AstronomyPictureModel>? astronomyPictures,
  }) {
    return HomeState(
      status: status ?? this.status,
      astronomyPictures: astronomyPictures ?? this.astronomyPictures,
    );
  }
  
  @override
  List<Object?> get props => [status, astronomyPictures];
}
