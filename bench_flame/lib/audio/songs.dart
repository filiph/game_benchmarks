const List<Song> songs = [
  Song('f-minor.mp3', 'F Minor', artist: 'Philip Age'),
];

class Song {
  final String filename;

  final String name;

  final String? artist;

  const Song(this.filename, this.name, {this.artist});

  @override
  String toString() => 'Song<$filename>';
}
