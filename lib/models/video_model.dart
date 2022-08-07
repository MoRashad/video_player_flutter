class Videos {
  late final String videoUrl, title;
  Duration? lastPosition;
  Videos({
    required this.videoUrl,
    required this.title,
  });
}

List<Videos> videos = [
  Videos(
    videoUrl:
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    title: 'ForBiggerBlazes',
  ),
  Videos(
    videoUrl:
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    title: 'BigBuckBunny',
  ),
  Videos(
    videoUrl:
        'http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8',
    title: 'skate_phantom_flex_4k',
  ),
  Videos(
    videoUrl:
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    title: 'ForBiggerBlazes',
  ),
  Videos(
    videoUrl:
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    title: 'BigBuckBunny',
  ),
];
