class Cow {
  Cow({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.type,
  });
  final int id;
  final String name;
  final int age;
  final String gender;
  final String type;
}

class DiagnosisResult {
  DiagnosisResult({
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
}

class DiagnosisHistory {
  DiagnosisHistory({
    required this.id,
    required this.date,
    required this.cowName,
    required this.result,
  });
  final int id;
  final DateTime date;
  final String cowName;
  final DiagnosisResult result;
}
