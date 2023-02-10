import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkingHelper{
  final String url;

  NetworkingHelper({required this.url});

  Future<dynamic> getData() async {
    final response = await http.get(Uri.parse(
        url));
    if(response.statusCode == 200){
      var data = response.body;
    var decodedData = jsonDecode(data);
    return decodedData;
    }else{
      print(response.statusCode);
    }
  }

}