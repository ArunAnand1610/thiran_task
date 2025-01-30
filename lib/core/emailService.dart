import 'package:github_stars_app/model/transactinModel.dart';

class EmailService {
  static Future<void> sendEmail(
      List<TransactionModel> errorTransactions) async {
    if (errorTransactions.isEmpty) return;
    String emailContent = 'Error Transactions:\n';
    for (var transaction in errorTransactions) {
      emailContent +=
          '${transaction.description}, Status: ${transaction.status}, Date: ${transaction.dateTime}\n';
    }
    print(
        emailContent); // Simulate sending email (Use external APIs for real implementation)
  }
}
