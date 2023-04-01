class Question {
  final String text;

  Question({required this.text});

  @override
  String toString() {
    return text;
  }

  static Question fromString(String string) {
    return Question(text: string);
  }
}
