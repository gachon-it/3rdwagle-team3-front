class DiaryRequest {
  final String voiceFilePath;
  final String emotion;

  DiaryRequest({
    required this.voiceFilePath,
    required this.emotion,
  });

  Map<String, dynamic> toJson() {
    return {
      'voice': voiceFilePath,
      'emotion': emotion,
    };
  }
}
