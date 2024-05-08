import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resep_makanan/model/resep.dart';

class ResepApi {
// const req = unirest('GET', 'https://yummly2.p.rapidapi.com/feeds/list');

// req.query({
  // limit: '24',
  // start: '0'
// });

// req.headers({
  // 'X-RapidAPI-Key': '7f969882f8mshbc4546cdeb1a710p12f233jsnd7be72118cb6',
  // 'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
// });

  static Future<List<Resep>> getResep() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "24", "start": "0", "tag": "list.receipt.popular"});

    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': '7f969882f8mshbc4546cdeb1a710p12f233jsnd7be72118cb6',
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
    });

    Map data = jsonDecode(response.body);

    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Resep.resepFromSnapshot(_temp);
  }
}
