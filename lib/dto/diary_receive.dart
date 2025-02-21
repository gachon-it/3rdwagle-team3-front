class DiaryReceive {
  final String text;
  final String comment;

  DiaryReceive({
    required this.text,
    required this.comment,
  });

  // JSON에서 객체 생성
  factory DiaryReceive.fromJson(Map<String, dynamic> json) {
    return DiaryReceive(
      text: json['text'] as String,
      comment: json['comment'] as String,
    );
  }
}
