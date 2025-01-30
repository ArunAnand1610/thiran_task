import 'package:github_stars_app/model/tickermodel.dart';

abstract class TicketState {}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {
  final List<TicketModel> tickets;
  TicketLoaded(this.tickets);
}

class TicketError extends TicketState {
  final String message;
  TicketError(this.message);
}
