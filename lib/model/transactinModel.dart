class TransactionModel {
  final int? id;
  final String description;
  final String status;
  final int dateTime;

  TransactionModel({
    this.id,
    required this.description,
    required this.status,
    required this.dateTime,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      description: map['description'],
      status: map['status'],
      dateTime: map['dateTime'],
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'description': description,
      'status': status,
      'dateTime': dateTime,
    };
    if (id != null) map['id'] = id as String;
    return map;
  }
}
