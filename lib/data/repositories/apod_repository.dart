import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

import '../../domain/models/astronomy_picture_model.dart';
import '../datasource/local/entities/apod_entity.dart';
import '../datasource/remote/api/apod_api.dart';
import '../datasource/remote/dto/apod_response_dto.dart';
import '../datasource/remote/mappers/apod_response_dto_mapper.dart';

class APODRepository {

  APODRepository({required this.apodApi});
  final APODApi apodApi;

  Future<List<AstronomyPictureModel>> getApods(
      int count, bool thumbs, String apiKey) {
    return apodApi
        .getApods(count, thumbs, apiKey)
        .then((List<APODResponseDTO> apodListResponseDTO) {
      final List<AstronomyPictureModel> data = apodListResponseDTO
          .map((APODResponseDTO apodResponseDTO) => apodResponseDTO.toDomain())
          .toList();
      saveAstronomyPictures(data);
      return data;
    });
  }

  // Save a list of AstronomyPictureModel
  Future<void> saveAstronomyPictures(
      List<AstronomyPictureModel> astronomyPictures) async {
    final List<APODEntity> apodEntities = astronomyPictures
        .map((AstronomyPictureModel apod) => APODEntity(
              title: apod.title,
              explanation: apod.explanation,
              date: apod.date,
              url: apod.url,
              hdurl: apod.hdurl,
              mediaType: apod.mediaType,
              serviceVersion: apod.serviceVersion,
            ))
        .toList();
    final Box<List<APODEntity>> box = await Hive.openBox<List<APODEntity>>('apodBox');
    box.put('apodList', apodEntities);
  }

  // Retrieve the list
  Future<List<AstronomyPictureModel>?> getLocalAstronomyPictures() async {
    final Logger logger = Logger();
    try {
      final Box<List<APODEntity>> box = await Hive.openBox<List<APODEntity>>('apodBox');
      final List<APODEntity>? data = box.get('apodList');
      data?.forEach((APODEntity element) {
        logger.i('Database element: ${element.title}');
      });
      return data
              ?.map((APODEntity entity) => AstronomyPictureModel(
                  title: entity.title,
                  explanation: entity.explanation,
                  date: entity.date,
                  url: entity.url,
                  hdurl: entity.hdurl,
                  mediaType: entity.mediaType,
                  serviceVersion: entity.serviceVersion))
              .toList() ??
          <AstronomyPictureModel>[];
    } catch (e) {
      return <AstronomyPictureModel>[];
    }
  }
}
