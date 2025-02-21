import 'dart:convert';

class DiaryModel {
  final String content;
  final String emotion;
  final String comment;

  DiaryModel({
    required this.content,
    required this.emotion,
    required this.comment,
  });

  factory DiaryModel.fromJson(Map<String, dynamic> json) {
    return DiaryModel(
      content: json['content'] ?? '',
      emotion: json['emotion'] ?? '',
      comment: json['comment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'emotion': emotion,
      'comment': comment,
    };
  }
}

class DiaryEntries {
  final Map<DateTime, List<DiaryModel>> diary;

  DiaryEntries({required this.diary});

  factory DiaryEntries.fromJson(Map<String, dynamic> json) {
    final Map<DateTime, List<DiaryModel>> diaryEntries = {};
    json.forEach((key, value) {
      DateTime date = DateTime.parse(key);
      diaryEntries[date] =
          (value as List).map((entry) => DiaryModel.fromJson(entry)).toList();
    });
    return DiaryEntries(diary: diaryEntries);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    diary.forEach((key, value) {
      json[key.toIso8601String().split('T')[0]] =
          value.map((entry) => entry.toJson()).toList();
    });
    return json;
  }

  void add(DateTime date, DiaryModel entry) {
    if (diary.containsKey(date)) {
      diary[date]!.add(entry);
    } else {
      diary[date] = [entry];
    }
  }
}

void testDiaryRepository() {
  // JSON 문자열 예제
  String jsonString = '''{
    "2025-01-01": [
      {
        "content": "나는 밥을 먹었다. 맛있었다.",
        "emotion": "좋음.",
        "comment": "참 잘했어요."
      },
      {
        "content": "나는 산책을 했다.",
        "emotion": "행복.",
        "comment": "상쾌했다."
      }
    ],
    "2025-01-02": [
      {
        "content": "나는 잠을 잤다.",
        "emotion": "좋음.",
        "comment": "참 잘했다."
      }
    ]
  }''';

  // JSON -> 객체 변환
  Map<String, dynamic> jsonMap = json.decode(jsonString);
  DiaryEntries diary = DiaryEntries.fromJson(jsonMap);

  // 새로운 다이어리 항목 추가
  diary.add(DateTime.parse("2025-01-01"),
      DiaryModel(content: "나는 운동을 했다.", emotion: "뿌듯함", comment: "잘했다!"));

  // 객체 -> JSON 변환
  String encodedJson = json.encode(diary.toJson());
  print(encodedJson);
}
