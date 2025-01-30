import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:github_stars_app/model/tickermodel.dart';

class FirebaseService {
  final CollectionReference ticketsCollection =
      FirebaseFirestore.instance.collection('tickets');

  Future<void> uploadTicket(TicketModel ticket) async {
    try {
      await ticketsCollection.doc(ticket.id).set(ticket.toMap());
    } catch (e) {
      throw Exception("Error uploading ticket: $e");
    }
  }

  Future<List<TicketModel>> getTickets() async {
    try {
      final snapshot = await ticketsCollection.get();
      return snapshot.docs
          .map((doc) => TicketModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Error retrieving tickets: $e");
    }
  }
}
