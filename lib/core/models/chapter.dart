enum ChapterStatus {
  locked,
  available,
  completed,
}

class Chapter {
  final String id;
  final String title;
  ChapterStatus status;

  Chapter({
    required this.id,
    required this.title,
    this.status = ChapterStatus.locked,
  });
}