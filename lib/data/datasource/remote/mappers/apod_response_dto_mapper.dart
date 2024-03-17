import 'package:astronomy_gallery/data/datasource/remote/dto/apod_response_dto.dart';
import 'package:astronomy_gallery/domain/models/astronomy_picture_model.dart';

extension APODResponseDTOMapper on APODResponseDTO {
  AstronomyPictureModel toDomain() {
    return AstronomyPictureModel(
      title: title,
      explanation: explanation,
      date: date,
      url: url,
      hdurl: hdurl,
      mediaType: mediaType,
      serviceVersion: serviceVersion,
    );
  }
}