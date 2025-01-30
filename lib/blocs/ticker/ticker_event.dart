import 'package:github_stars_app/model/tickermodel.dart';

abstract class TicketEvent {}

class AddTicket extends TicketEvent {
  final TicketModel ticket;
  AddTicket(this.ticket);
}

class FetchTickets extends TicketEvent {}
