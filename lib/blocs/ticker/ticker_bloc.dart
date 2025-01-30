import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_stars_app/blocs/ticker/ticker_event.dart';
import 'package:github_stars_app/blocs/ticker/ticker_state.dart';
import 'package:github_stars_app/core/tickerRepo.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final TicketRepository repository;

  TicketBloc(this.repository) : super(TicketInitial()) {
    // Registering event handlers
    on<AddTicket>(_onAddTicket);
    on<FetchTickets>(_onFetchTickets);
  }

  // Handle AddTicket event
  Future<void> _onAddTicket(AddTicket event, Emitter<TicketState> emit) async {
    try {
      await repository.addTicket(event.ticket);
      final updatedTickets = await repository.getTickets();
      emit(TicketLoaded(updatedTickets)); // Emit updated state
    } catch (e) {
      emit(TicketError("Error adding ticket: ${e.toString()}"));
    }
  }

  // Handle FetchTickets event
  Future<void> _onFetchTickets(
      FetchTickets event, Emitter<TicketState> emit) async {
    emit(TicketLoading());
    try {
      final tickets = await repository.getTickets();
      emit(TicketLoaded(tickets));
    } catch (e) {
      emit(TicketError("Failed to fetch tickets: ${e.toString()}"));
    }
  }
}
