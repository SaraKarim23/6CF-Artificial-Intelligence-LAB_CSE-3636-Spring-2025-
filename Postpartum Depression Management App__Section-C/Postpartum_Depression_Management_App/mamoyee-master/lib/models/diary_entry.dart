class DiaryEntry {
  final DateTime date;
  final String content;

  DiaryEntry({
    required this.date,
    required this.content,
  });

  // Convert DiaryEntry to Map for saving
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'content': content,
    };
  }

  // Create DiaryEntry from Map
  factory DiaryEntry.fromMap(Map<String, dynamic> map) {
    return DiaryEntry(
      date: DateTime.parse(map['date']),
      content: map['content'],
    );
  }

  @override
  String toString() {
    return 'DiaryEntry(date: $date, content: $content)';
  }
}
