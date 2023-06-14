import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gbhss_library/model/result.dart';
import 'package:gbhss_library/view_model/book_provider.dart';
import 'package:provider/provider.dart';

import '../../../model/book.dart';

class BookSearchScreen extends StatelessWidget {
  BookSearchScreen({Key? key}) : super(key: key);

  final isbnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book search')),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Text('Find Your Book', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            TextField(
              controller: isbnController,
              decoration: InputDecoration(
                hintText: 'Enter ISBN Number',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(msg: 'Currently unavailable');
                  },
                  child: Icon(Icons.camera_alt, size: 24, color: Colors.grey[600]),
                ),
              ),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                int? isbn = int.tryParse(isbnController.text);
                if (isbn != null) {
                  Provider.of<BookProvider>(context, listen: false).loadBook(isbn);
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Consumer<BookProvider>(
                          builder: (ctx, provider, child) {
                            if (provider.status == Status.success) {
                              return BookDialog(book: provider.book);
                            } else if (provider.status == Status.loading) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 16),
                                  Text(
                                    'Loading...',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              );
                            } else if (provider.status == Status.error) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.error_outline, size: 48, color: Colors.red),
                                  SizedBox(height: 16),
                                  Text(
                                    'Error occurred.',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                                  ),
                                ],
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  Fluttertoast.showToast(msg: 'Invalid ISBN');
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Search', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class BookDialog extends StatelessWidget {
  final Book book;

  const BookDialog({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Title:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('${book.title}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
          SizedBox(height: 16),
          if (book.subtitle != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subtitle:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('${book.subtitle}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                SizedBox(height: 16),
              ],
            ),
          if (book.description != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('${book.description}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                SizedBox(height: 16),
              ],
            ),
          if (book.author != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Author:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('${book.author}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                SizedBox(height: 16),
              ],
            ),
          if (book.publisher != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Publisher:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('${book.publisher}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                SizedBox(height: 16),
              ],
            ),
          if (book.publishedDate != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Published Date:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('${book.publishedDate}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                SizedBox(height: 16),
              ],
            ),
          if (book.pages != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pages:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('${book.pages}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                SizedBox(height: 16),
              ],
            ),
          if (book.rating != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rating:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('${book.rating}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                SizedBox(height: 16),
              ],
            ),
          if (book.language != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Language:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('${book.language}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
              ],
            ),
        ],
      ),
    );
  }
}
