class AstronomyPictureModel {
  const AstronomyPictureModel({
    required this.title,
    required this.explanation,
    required this.date,
    required this.url,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
  });

  final String title;
  final String explanation;
  final String date;
  final String url;
  final String hdurl;
  final String mediaType;
  final String serviceVersion;

  static const List<AstronomyPictureModel> astronomyPictures = <AstronomyPictureModel>[
    AstronomyPictureModel(
      title: 'The Sea Beast',
      explanation:
          'This image is a close-up of the head of the Seagull Nebula. It is a composite of images taken in the light of ionized hydrogen (H-alpha) and oxygen (OIII).',
      date: '2022-10-01',
      url: 'https://apod.nasa.gov/apod/image/9612/ngc2440_hst2.jpg',
      hdurl: 'https://apod.nasa.gov/apod/image/9612/ngc2440_hst2_big.jpg',
      mediaType: 'image',
      serviceVersion: 'v1',
    )
  ];

  @override
  String toString() {
    return 'AstronomyPictureModel(title: $title, date: $date, url: $url, hdurl: $hdurl, mediaType: $mediaType)';
  }
}
