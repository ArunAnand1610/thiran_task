// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_stars_app/blocs/ticker/ticker_bloc.dart';
import 'package:github_stars_app/blocs/ticker/ticker_state.dart';
import 'package:github_stars_app/screens/addticket.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketListScreen extends StatelessWidget {
  const TicketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFF68529),
        title: Text(
          "Tickets List",
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
        ),
      ),
      body: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          if (state is TicketLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TicketLoaded) {
            return ListView.builder(
              itemCount: state.tickets.length,
              itemBuilder: (context, index) {
                final ticket = state.tickets[index];
                return Card(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: ticket.attachment != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(ticket.attachment,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.network(
                                        "https://avatars.githubusercontent.com/u/37220920?v=4")),
                          )
                        : Icon(Icons.report, size: 50, color: Colors.redAccent),
                    title: Text(
                      ticket.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ticket.description,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 14, color: Colors.grey),
                            SizedBox(width: 4),
                            Text(ticket.location,
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Reported on: ${ticket.date}",
                          style:
                              TextStyle(fontSize: 12, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle tile tap event
                    },
                  ),
                );
              },
            );
          } else if (state is TicketError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text("No Tickets Found"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TicketFormScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
