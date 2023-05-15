import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = {
    "type": "service_account",
    "project_id": "crop-383917",
    "private_key_id": "0afa39181ea29d36c5f80fe72416a0ba8198a872",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC0ObueLfEcu54q\nmO/986xJy6aBhAX7e2E/b31yy2pEOmscTAgIv48h/658/QUgZQVpuBicJbJ48nUy\nIGVaK1pFxrGCbtOgF+G2Ktnvr/T4JhNnSV/hNRY2TwHOTJWl7vj1o4/PRYBfu/cI\n0TxJ0q0hXlPoMsxXPO65KGpaw/FY8eItLbjf/6ZoCi733hHYWnpmntr6HFM0fjVn\nds7bWwJNbwoNobmNdoWgJbK6gnKHuESpiX1Hapfq0cZJGGwnCUyEib2mrNS8dPw3\nlKP4/toNS0ujoJEgPUlcf7/SgrqK4qRxw4oopq9puesCkyw96jodfrFueOfo18xl\n8hDtXBthAgMBAAECggEAE2MqhaeXimm8aASvvHfcDswzizcylYz+Nx69Nf4f3lsS\nbqbXLmm88gFZOeTWClgTrv242ANOIaijZtMJVBvZyCvJqKhXZ59qDnipnRkmlxMx\nfyjrgYR+cTUqkpC2gHUmnvYLYFavqpzDxFUN0TsymKZXDGF6jd/mJlDsr/roGZMt\nGprR21+WfFRWZEVXAj2jLm03TweRWL/a7ZjedJKFohzjiofuSAbCTCXdPkGFPaRs\nSfidEIYF64DCjytEOp9Ysb747Tl0iw0HQiDFca8gL/rDCN6H+bkDPl1OI+cpWvN0\niW/Nbrl0Olo4N6c7PT0mz2IC7/HHC9RQs+PGcBWp4QKBgQDzBl/XRJE25DJZ+rr/\n+1XG9i29DA8kNd1ws3tHN+s2AhgcNjqR2s4vhDK/75XqUmIMzkgVooYZVe0U2iSy\nbFm7fGdBLBER/yfXB3PmwBRpd3ipEVCGqCgP7iYnIRryHc4URitobQ4tIBULEaQA\njK7peTUVMmr5QGns3rDs3d283QKBgQC92QbNQ/CCsNcUXhmVCaiicV8doWa3J0D9\nJuGZ4ypKDmOUBsXmaQ0zEki9VkMLsDqfnzw2ACQ+CTZkmYQfxSi6deHA9NIqI0f6\nTDt6+Pxh8poYvo53ipDw1F3vge9A+mCehHlOvZjWZLdyI1r8LdcqIa33FsW1Of24\n4oaOwByeVQKBgFJ5alMi6Oko/lF8/rNat1yDNTh//C98vD7AGmkr9/3nLgl8+dl/\n2RNVGOf8RfM0rCPOabY15q54c7Hs6iFHFhjDekMq0kw6PGoEFHhN3V+BdQhjYOGh\n9Z6aYoZK/NsH9GT6/0Y8JGB6D8om3XJ2S/Hd+X7NEnKuQoRper+X9+VdAoGAMywJ\nglCaxo9mGe5XVO3aj5ahfboglqO1B8dwLeumXXnNa3v74eRVE3wNMUPMJJ1m39mr\nAB8/pZ0UFT+v9mRNWx0lMb6L26HQ5+2eZsIwPTKISL0sZ5ppAREtFL7gP5J9cpzg\nmdHPHZLeQ5y2DJ1KjuevHZf8yKGN+0TL4jR0QlUCgYAx4r263zHMz8ONp8GezCNU\nz5CN39KbnRZcEeL66dJ6Zv9xBwo+0gI1J6mGWaaaApbLmbiVpa/wXM3UX0JUKkod\nCuHehkFJNi3xD7QF6ydBHWE8S9XL57LIkGNibd7I3kfEAE3qMRk5cOV4lyOfbe39\nsBz+Q/OXZ9lhi/qaWEiwvQ==\n-----END PRIVATE KEY-----\n",
    "client_email": "232309452284-compute@developer.gserviceaccount.com",
    "client_id": "111722278748339087625",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/232309452284-compute%40developer.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  };

  // set up & connect to the spreadsheet
  static const _spreadsheetId =
      '232309452284-compute@developer.gserviceaccount.com';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    print(currentTransactions);
    // this will stop the circular loading indicator
    loading = false;
  }

  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}
