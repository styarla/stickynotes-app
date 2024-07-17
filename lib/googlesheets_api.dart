import 'package:gsheets/gsheets.dart';

class GSheetsAPI{
  //creating credentials
  static const _credentials= r'''
  {
  "type": "service_account",
  "project_id": "flutter-project-429712",
  "private_key_id": "403a67e6868536d8e85ccdb57075fd39b70d3c38",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDAP80jYT94sG5F\noJ7RIhAYuuN9alKQCCIY2cEvzL+265vx7AmWCRBS90AO41oceJ0H5kPK22khSu+A\nHEINlPYkakx3+tDMtrXV9fpuatoWJUTPl2XspjGwdfs8FVs3jbkiPcTH962Y2eK2\nuhd6/hQ4Fqd6c6lOrOK89V5YX0cdj3dcMTbsZfW5H8FP1aQHVcxdVsUZl8mEvSJ3\n7a90RIZGWLiYZC5Sjxiijsrwgp/uzzSLkwphI1Wf5Y+yXFEbPChBBaVigphWs1cO\nNW5UxqQXiw9qOcSGurBgzDX7nSwjzQ8Bpjs2kSBMFYAkhGkX5CgevL/fy+OeFDgC\nVWGVnj3lAgMBAAECggEAP5pcEeJwj0s/kEWNhX8ReD0MWke8vO4T6cjRAzFoE+pr\nE2SV309sWSZ3yPUqsNSujxh9QTXJ2DvkdKvkpn2r2WxZlDAkuDWSfxD8I1+yezUl\nSNC75ckuE0VVMxGVthFrOIra+ZVVl4YuXWm/ru80XUIRco+laeQEt6Mt7WrIKlzi\nYmSatz/Sy43pp1utokX7VyQBfGKEdCGSNa1dDGyySBN2KepWN9tooU80Fv0hgyJe\nOi5zacpZbUwQYikJejUd2vGzMZzByHdyKP+VYrLZ3s43U9jVWp0BnNN+/kJNXP+y\neLDEFGZbFobzH5UgUvbnV+OqpT8+uJRxivKElu+5mQKBgQD+bECKmaBmFSTEFtpD\npoFL01m+9HErB7tZJ4uHzFIEuP1NOk34qsrwSvCmHUTL0VX7sWpKL47kj+VRJpEj\nZTu7b7wLrbf9Opw2aeUC3h02bLpf/V0yHbvKZuPPefyLK3nYAlNCjSuHCGIRKSdS\nbBc9R50zNUmjEDpvWPIiDnpG0wKBgQDBcOKD5dVt4ToYYyoe35hKcxcoSVPajghM\nwjtZM2o4k1utI9k8jGDazw9DJLITHUMtUnDxl2gOdFHJlT8CgZJJ0h6G2MGXq9aV\nOB4X/Af+9/YWnjCBdjce6WN0lU5ousY4t3Ow+rHm2Y4mq1szVmXEe1LPLRJ8uYvt\nRUl3kgvlZwKBgQD79iro2AGwdwoFI/id/JyZgkKjyKL2kV6piW82WlNzl9xLCg3D\n0SjPVfgDGoNSMgssCuSPeY/SrOrWNhKQciX4l0wsaKsInm2rua1x7JQTnRPqEhmk\nkyux47mCdHV1QeYV1R+tje7oeJXeFtp5VtChAHYfC4vUcDLeqMCKl7nivwKBgGYC\nIXFswiAvpXM21/9v6d9Y0d1szctzGu1ff+yKMHmlO7MSNHy5ilnY1zORJlbuF37O\n+sBsF3OH45lqGtA3g+1p4K87nttcwsvty/DZ9119ZUiIIwwiSu8CJHBWTALue5lt\nJJUvnqEeGNhLhMyNwxzZ69FU82rSbfexkgx798oBAoGBANCzyuOkhbq0ENcG3WsH\nbGD0AMVtfV8stRMa1IXAQjQAFxkfw17vytLBuN0lzX/F0Dl/urVKTtBPNMzm+TuT\nhXxXg+gZLpq6YPtT7KzoUP0Srwo3xnOm37OQZFm6SB1v3xGx9Zy6/IN4amWrEqVM\n7ukEqWjJRN2QTw7Q2OnjSF1B\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-project@flutter-project-429712.iam.gserviceaccount.com",
  "client_id": "100117209213561966220",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-project%40flutter-project-429712.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
  }
  ''';

  //spreadsheet id
  static final _spreadsheetId= '1OB7iQW9NI8xloQNXE5ykxdXUB1E9E_l2D52krUAFuJo';
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