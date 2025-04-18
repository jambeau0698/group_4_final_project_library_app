import 'package:flutter/material.dart';
import 'package:group_4_final_project_library_app/core/db_helper.dart';
import 'package:group_4_final_project_library_app/models/Book.dart';


class booksPage extends StatelessWidget{
  DBHelper db = new DBHelper();
  final List<Book> books = db.getAllBooks();

 @override
 build(BuildContext context){
   return Scaffold(
     body: BookGrid(books: books),
   );
 }

}


class BookGrid extends StatelessWidget {
  final List<Book> books; // Your Book model should have `title` and `imageUrl`

  const BookGrid({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: books.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1, // Makes the tiles square
        ),
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      book.coverArt,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    book.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
