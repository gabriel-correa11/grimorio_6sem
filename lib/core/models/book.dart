import 'package:grimorio/core/models/chapter.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String imagePath;
  final List<Chapter> chapters;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imagePath,
    required this.chapters,
  });
}