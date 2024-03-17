import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class APODResponseDTO {
  final String date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;

  APODResponseDTO({
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
  });

  factory APODResponseDTO.fromJson(Map<String, dynamic> json) {
    return APODResponseDTO(
      date: json['date'],
      explanation: json['explanation'],
      hdurl: json['hdurl'],
      mediaType: json['media_type'],
      serviceVersion: json['service_version'],
      title: json['title'],
      url: json['url'],
    );
  }
}