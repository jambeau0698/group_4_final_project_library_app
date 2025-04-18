class Book{
  int? bookId;
  String? title, author, genre, description, coverArt;
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
}