class Book{
  int? bookId;
  String title, author, genre, description, coverArt;
  Book(this.title, this.author, this.genre, this.description, this.coverArt);
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'genre': genre,
      'description': description,
      'bookCover': coverArt,
    };
  }
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      map['title'],
      map['author'],
      map['genre'],
      map['description'],
      map['bookCover'],
    );
  }
}