//iqoo - 192.168.53.129
//bsnl - 192.168.1.23
//192.168.53.129
//hotspot:192.168.222.129


// List<dynamic>dta=[ ]; //dt
// List<dynamic>tme=[ ]; //dte
// dynamic prev=0;
// String name='';
// String email='';//'a';
// String baseurl='http://192.168.222.129:8000';
// int?id;
// int?age;
// double?height;
// double?weight;
// String bloodgroup='';
// String phone='';
// String notification='No data found please add reading';
class DataStore {
  static final DataStore _instance = DataStore._internal();

  factory DataStore() {
    return _instance;
  }

  DataStore._internal();

  List<dynamic> dta = []; //dt
  List<dynamic> tme = []; //dte
  List<dynamic> bphdta = []; //dt
  List<dynamic> bpldta = []; //dt
  List<dynamic> bptme = [];
  dynamic prev = 0;
  dynamic bpprev = 0;
  String name = '';
  String email = ''; //'a';
  String baseurl = 'http://192.168.1.23:8000';
  int? id;
  int? age;
  double? height;
  double? weight;
  String bloodgroup = '';
  String phone = '';
  String notification = 'No data found please ';
  DateTime date=DateTime.now();
}