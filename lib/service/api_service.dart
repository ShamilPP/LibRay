import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:libray/model/book.dart';

import '../model/result.dart';

class ApiService {
  static Future<Result<Book>> getBookWithISBN(int isbn) async {
    final url = 'https://www.googleapis.com/books/v1/volumes?q=isbn:$isbn';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['totalItems'] > 0) {
          final bookData = jsonData['items'][0]['volumeInfo'];
          Book book = Book(
            title: bookData['title'],
            subtitle: bookData['subtitle'],
            description: bookData['description'],
            author: bookData['authors']?.join(', '),
            publisher: bookData['publisher'],
            publishedDate: bookData['publishedDate'],
            pages: bookData['pageCount'],
            rating: bookData['averageRating'],
            language: bookData['language'],
          );
          return Result.success(book);
        } else {
          return Result.error('No Book');
        }
      } else {
        return Result.error('Response code : ${response.statusCode}');
      }
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
