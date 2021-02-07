class Download {
  final String id;
  final String coverImageName;
  final String title;
  final String author;
  final String bookName;
  bool isDownloaded;
  Download(
      {this.id,
      this.coverImageName,
      this.title,
      this.author,
      this.bookName,
      this.isDownloaded = false});
  factory Download.fromMap(Map<String, dynamic> map) {
    return Download(
      id: map['id'],
      coverImageName: map['image_name'],
      title: map['title'],
      author: map['author'],
      bookName: map['book_name'],
      isDownloaded: map['is_downloaded'] == 'true',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image_name': coverImageName,
      'title': title,
      'author': author,
      'book_name': bookName,
      'id': id,
      'is_downloaded': isDownloaded.toString(),
    };
  }
}
