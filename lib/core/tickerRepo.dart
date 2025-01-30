import 'package:github_stars_app/core/databaseHelper.dart';
import 'package:github_stars_app/core/firebaseService.dart';
import 'package:github_stars_app/model/tickermodel.dart';

class TicketRepository {
  final DatabaseHelper databaseHelper;
  final FirebaseService firebaseService;

  TicketRepository(this.databaseHelper, this.firebaseService);

  Future<void> addTicket(TicketModel ticket) async {
    await databaseHelper.insertTicket(ticket);
    await firebaseService.uploadTicket(ticket);
  }

  Future<List<TicketModel>> getTickets() async {
    return await databaseHelper.getTickets();
  }
}
