import 'package:astronomy_gallery/data/repositories/apod_repository.dart';
import 'package:astronomy_gallery/domain/models/astronomy_picture_model.dart';
import 'package:mockito/mockito.dart';

class MockAPODRepository extends Mock implements APODRepository {
  @override
  Future<List<AstronomyPictureModel>> getApods(
      int count, bool thumbs, String apiKey) {
    return super.noSuchMethod(
      Invocation.method(#getApods, [count, thumbs, apiKey]),
      returnValue: Future.value(
          <AstronomyPictureModel>[]), // Return an empty list by default
      returnValueForMissingStub: Future.value(<AstronomyPictureModel>[]),
    );
  }
}
