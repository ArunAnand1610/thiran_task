import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_stars_app/blocs/github/github_bloc.dart';
import 'package:github_stars_app/blocs/github/github_state.dart';
import 'package:github_stars_app/core/databaseHelper.dart';
import 'package:github_stars_app/model/transactinModel.dart';
import 'package:github_stars_app/screens/tickerDetails.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmanager/workmanager.dart';

class ReopDetailsScreen extends StatelessWidget {
  const ReopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFF68529),
        title: Text(
          "Trending GitHub Repos",
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
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TicketListScreen()));
            },
            child: Container(
              height: 40,
              width: 80,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Tickets",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              final dbHelper = DatabaseHelper();
              print("Transaction inserted start.");
              // Insert transaction into the database
              await dbHelper.insertTransaction(TransactionModel(
                description: 'UpdatePerson',
                status: 'Error',
                dateTime: DateTime.now().microsecondsSinceEpoch,
              ));
              print("Transaction inserted successfully.");

              // Register a one-off task
              Workmanager().registerOneOffTask(
                'uniqueTaskId',
                'mySimpleTask',
                initialDelay: const Duration(minutes: 1),
              );
              print('Task Scheduled');
            },
            child: Container(
              height: 40,
              width: 80,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Mails",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<GithubBloc, GithubState>(
        builder: (context, state) {
          if (state is GithubLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GithubLoaded) {
            return ListView.builder(
              itemCount: state.repositories.length,
              itemBuilder: (context, index) {
                final repository = state.repositories[index];
                return Card(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                  elevation: 2, // Adds a shadow effect
                  // Spacing around the card
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.only(left: 16, right: 16, top: 8),
                    leading: CircleAvatar(
                      maxRadius: 24,
                      backgroundImage: NetworkImage(repository.avatarUrl),
                    ),
                    title: Text(
                      repository.name,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      repository.description,
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    trailing: Text(
                      "${repository.stars} ⭐",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.amber[700], // Color for the star rating
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Failed to load data"));
          }
        },
      ),
    );
  }
}
