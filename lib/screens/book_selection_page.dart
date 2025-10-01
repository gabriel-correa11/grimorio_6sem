import 'package:flutter/material.dart';
import '../quiz_brain.dart';
import '../theme/app_colors.dart';

class BookSelectionPage extends StatefulWidget {
  const BookSelectionPage({super.key});

  @override
  State<BookSelectionPage> createState() => _BookSelectionPageState();
}

class _BookSelectionPageState extends State<BookSelectionPage> {
  final QuizBrain quizBrain = QuizBrain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha um Livro'),
      ),
      body: ListView.builder(
        itemCount: quizBrain.getBookCount(),
        itemBuilder: (context, index) {
          final book = quizBrain.getBook(index);
          return Card(
            color: AppColors.azulRoyal,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              onTap: () {
                Navigator.pushNamed(context, '/quiz', arguments: index);
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.asset(
                  book.imagePath,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                book.title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                book.author,
                style: TextStyle(color: Colors.grey[300]),
              ),
            ),
          );
        },
      ),
    );
  }
}