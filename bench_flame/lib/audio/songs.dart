const List<Song> songs = [
  Song('Majestic.mp3', 'Majestic (4.9MB)', artist: 'Unknown'),
];

class Song {
  final String filename;

  final String name;

  final String? artist;

  const Song(this.filename, this.name, {this.artist});

  @override
  String toString() => 'Song<$filename>';
}
