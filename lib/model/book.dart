class Book {
  final String imageLink;
  final String title;
  final String? subtitle;
  final String? description;
  final String? author;
  final String? publisher;
  final String? publishedDate;
  final int? pages;
  final double? rating;
  final String? language;

  Book({
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.pages,
    required this.rating,
    required this.language,
    required this.imageLink,
  });
}
