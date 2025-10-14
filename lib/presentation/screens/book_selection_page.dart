import 'package:flutter/material.dart';
import 'package:grimorio/core/logic/quiz_brain.dart';
import 'package:grimorio/presentation/screens/profile_page.dart';
import 'package:grimorio/presentation/screens/quiz_page.dart';
import 'package:grimorio/presentation/theme/app_colors.dart';
import 'package:grimorio/core/models/book.dart';

class BookSelectionPage extends StatefulWidget {
  const BookSelectionPage({super.key});

  @override
  State<BookSelectionPage> createState() => _BookSelectionPageState();
}

class _BookSelectionPageState extends State<BookSelectionPage> {
  final QuizBrain quizBrain = QuizBrain();
  late final List<Book> books;

  @override
  void initState() {
    super.initState();
    books = quizBrain.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha um Livro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            color: AppColors.azulRoyal,
            elevation: 4.0,
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              onTap: () {
                final questionsForBook = quizBrain.getQuestionsForBook(index);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(questions: questionsForBook),
                  ),
                );
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  book.imagePath,
                  width: 50,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                book.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                book.author,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}