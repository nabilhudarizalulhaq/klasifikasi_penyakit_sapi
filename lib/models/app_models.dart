import 'dart:convert';

class Cow {
  const Cow({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.type,
  });

  final int? id;
  final String name;
  final int age;
  final String gender;
  final String type;

  Cow copyWith({
    int? id,
    String? name,
    int? age,
    String? gender,
    String? type,
  }) {
    return Cow(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      type: type ?? this.type,
    );
  }

  Map<String, Object?> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'type': type,
    };
  }

  factory Cow.fromMap(Map<String, Object?> map) {
    return Cow(
      id: map['id'] as int?,
      name: map['name'] as String? ?? '',
      age: map['age'] as int? ?? 0,
      gender: map['gender'] as String? ?? '',
      type: map['type'] as String? ?? '',
    );
  }
}

class DiagnosisResult {
  const DiagnosisResult({
    required this.disease,
    required this.confidence,
    required this.severity,
    required this.recommendations,
    required this.symptoms,
  });

  final String disease;
  final int confidence;
  final String severity;
  final List<String> recommendations;
  final List<String> symptoms;

  DiagnosisResult copyWith({
    String? disease,
    int? confidence,
    String? severity,
    List<String>? recommendations,
    List<String>? symptoms,
  }) {
    return DiagnosisResult(
      disease: disease ?? this.disease,
      confidence: confidence ?? this.confidence,
      severity: severity ?? this.severity,
      recommendations: recommendations ?? this.recommendations,
      symptoms: symptoms ?? this.symptoms,
    );
  }
}

class DiagnosisHistory {
  const DiagnosisHistory({
    this.id,
    required this.date,
    this.cowId,
    required this.cowName,
    required this.result,
  });

  final int? id;
  final DateTime date;
  final int? cowId;
  final String cowName;
  final DiagnosisResult result;

  DiagnosisHistory copyWith({
    int? id,
    DateTime? date,
    int? cowId,
    String? cowName,
    DiagnosisResult? result,
  }) {
    return DiagnosisHistory(
      id: id ?? this.id,
      date: date ?? this.date,
      cowId: cowId ?? this.cowId,
      cowName: cowName ?? this.cowName,
      result: result ?? this.result,
    );
  }

  Map<String, Object?> toMap() {
    return {
      if (id != null) 'id': id,
      'date': date.toIso8601String(),
      'cow_id': cowId,
      'cow_name': cowName,
      'disease': result.disease,
      'confidence': result.confidence,
      'severity': result.severity,
      'recommendations': jsonEncode(result.recommendations),
      'symptoms': jsonEncode(result.symptoms),
    };
  }

  factory DiagnosisHistory.fromMap(
    Map<String, Object?> map,
  ) {
    return DiagnosisHistory(
      id: map['id'] as int?,
      date: DateTime.parse(
        map['date'] as String,
      ),
      cowId: map['cow_id'] as int?,
      cowName: map['cow_name'] as String? ?? 'Sapi Tidak Diketahui',
      result: DiagnosisResult(
        disease: map['disease'] as String? ?? '-',
        confidence: map['confidence'] as int? ?? 0,
        severity: map['severity'] as String? ?? '-',
        recommendations: _decodeStringList(
          map['recommendations'],
        ),
        symptoms: _decodeStringList(
          map['symptoms'],
        ),
      ),
    );
  }

  static List<String> _decodeStringList(Object? value) {
    if (value == null) {
      return [];
    }

    try {
      final decoded = jsonDecode(value.toString());

      if (decoded is List) {
        return decoded.map((item) => item.toString()).toList();
      }
    } catch (_) {
      return [];
    }

    return [];
  }
}