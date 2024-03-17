import 'package:astronomy_gallery/data/datasource/remote/api/apod_api.dart';
import 'package:astronomy_gallery/data/datasource/remote/dto/apod_response_dto.dart';
import 'package:astronomy_gallery/data/datasource/remote/mappers/apod_response_dto_mapper.dart';
import 'package:astronomy_gallery/domain/models/astronomy_picture_model.dart';

class APODRepository {
  final APODApi apodApi;

  APODRepository({required this.apodApi});

  Future<List<AstronomyPictureModel>> getApods(
      int count, bool thumbs, String apiKey) {
    return apodApi
        .getApods(count, thumbs, apiKey)
        .then((List<APODResponseDTO> apodListResponseDTO) {
      final List<AstronomyPictureModel> data = apodListResponseDTO
          .map((APODResponseDTO apodResponseDTO) => apodResponseDTO.toDomain())
          .toList();
      return data;
    });
  }
}
