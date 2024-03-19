import '../../../../domain/models/astronomy_picture_model.dart';
import '../dto/apod_response_dto.dart';

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