import 'package:flutter/material.dart';
import 'package:group_4_final_project_library_app/models/Book.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 14));


  Future<void> _selectReturnDate(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime oneMonthLater = today.add(const Duration(days: 30));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: today,
      lastDate: oneMonthLater,
      helpText: 'Select Return Date',
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top row: image and info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.book.coverArt,
                    width: 100,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.book.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'by ${widget.book.author}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.book.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            // Return Date Picker
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Return Date: ',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  '${_selectedDate.toLocal()}'.split(' ')[0], // Format to just date
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectReturnDate(context),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO Withdraw logic
                  },
                  icon: const Icon(Icons.assignment_return),
                  label: const Text('Withdraw'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}