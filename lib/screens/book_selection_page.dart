import 'package:flutter/material.dart';
import 'package:grimorio/screens/profile_page.dart';
import 'package:grimorio/screens/quiz_page.dart';
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
        itemCount: quizBrain.getBookCount(),
        itemBuilder: (context, index) {
          final book = quizBrain.getBook(index);
          return Card(
            color: AppColors.azulRoyal,
            elevation: 4.0,
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage(bookIndex: index)),
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
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                book.author,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 14,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[300],
                size: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}