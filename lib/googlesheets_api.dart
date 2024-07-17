import 'package:gsheets/gsheets.dart';

class GSheetsAPI{
  //creating credentials
  static const _credentials= r'''
  
  ''';

  //spreadsheet id
  static final _spreadsheetId= '';
  //init google sheet
  static final gsheets= GSheets(_credentials);
  static Worksheet? _worksheet;

  static int numberOfNotes=0;
  static List<String> currentNotes = [];
  static bool loading = true;


  Future init() async{
    //init spreadsheet by id
    final ss=  await gsheets.spreadsheet(_spreadsheetId);
    _worksheet= ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  static Future insert(String note) async{
    //init spreadsheet by id
    if (_worksheet == null) return;
    numberOfNotes++;
    currentNotes.add(note);
    await _worksheet!.values.appendRow([note]);
  }

  static Future countRows() async{
    while ((await _worksheet!.values.value(column: 1, row: numberOfNotes+1)) != ''){
      numberOfNotes++;
    }
    loadNotes();
  }

  static Future loadNotes() async {
    if (_worksheet == null) return;
    for (int i = 0; i < numberOfNotes; i++) {
      final String newNote = await _worksheet!.values.value(column: 1, row: i+1);
      if (currentNotes.length < numberOfNotes) {
        currentNotes.add(newNote);
      }
    }
    loading = false;
  }




}