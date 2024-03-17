import 'package:astronomy_gallery/data/datasource/remote/dto/apod_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class APODListResponseDTO {
  final List<APODResponseDTO> apods;

  APODListResponseDTO({
    required this.apods,
  });

  factory APODListResponseDTO.fromJson(Map<String, dynamic> json) {
    final apods = (json['apods'] as List)
        .map((e) => APODResponseDTO.fromJson(e as Map<String, dynamic>))
        .toList();
    return APODListResponseDTO(apods: apods);
  }
}
