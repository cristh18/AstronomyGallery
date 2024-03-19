import 'package:hive/hive.dart';
part 'apod_entity.g.dart';

@HiveType(typeId: 0)
class APODEntity extends HiveObject {
  APODEntity({
    required this.title,
    required this.explanation,
    required this.date,
    required this.url,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
  });
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String explanation;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final String url;

  @HiveField(4)
  final String hdurl;

  @HiveField(5)
  final String mediaType;

  @HiveField(6)
  final String serviceVersion;
}
