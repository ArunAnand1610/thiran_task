class TicketModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String date;
  final String attachment;

  TicketModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.attachment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'date': date,
      'attachment': attachment,
    };
  }

  static TicketModel fromMap(Map<String, dynamic> map) {
    return TicketModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      location: map['location'],
      date: map['date'],
      attachment: map['attachment'],
    );
  }
}
