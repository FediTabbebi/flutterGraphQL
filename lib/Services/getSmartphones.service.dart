
import 'dart:async';
import 'dart:convert';

import 'package:flutter_graphql/Model/smartphoneModel.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:flutter_graphql/globals/globals.dart';


//StreamController<Smartphone> _streamController=StreamController() ;
 class APIService {
  
//   static  Stream<List<Smartphone>?> getAllSmartphones() async* {
    
//     var headers = {'Content-Type': 'application/json'};
// 		var request = http.Request('GET', Uri.parse('http://192.168.2.130:4000/graphql'));

// 		request.body = '''{"query":"query {Smartphones {id brand Display_Quality Screen_Size Camera Storage Battery Operating_System}}","variables":{}}'''; 
// 		request.headers.addAll(headers);
// 	  http.StreamedResponse response = await request.send();

//     final body=jsonDecode(await response.stream.bytesToString());
// 	  final decodedJson = body["data"]["Smartphones"];
//     final List<Smartphone> smartphones ;

//     if (response.statusCode == 200) {
//       smartphones=decodedJson.map<Smartphone>(Smartphone.fromJson).toList();
//       //_streamController.sink.add(smartphones.last);
//     if (smartphones.isEmpty) {
//       yield null;
//     }
//     else {
//       yield smartphones ;
//     }
//   }
  
// 	}


		static   addSmartphone(
      brand,displayQuality, screenSize,camera,storage,  battery, operatingSystem ) async {

    	var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse('http://192.168.2.130:4000/graphql'));
      request.body = '''{"query":"  mutation {addNewSmartphone (smartphone: {brand:\\"$brand\\" Display_Quality: \\"$displayQuality\\" Screen_Size : \\"$screenSize\\" Camera:\\"$camera\\" Storage:\\"$storage\\" Battery: \\"$battery\\" Operating_System : \\"$operatingSystem\\"\\r\\n} ) { brand Display_Quality Screen_Size Camera Storage Battery }}\\r\\n","variables":{}}''';

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send(); 

      if (response.statusCode == 200) {
      addphone=true;
	    //	print(await response.stream.bytesToString());
      }
      else {
		  //print(response.reasonPhrase);
      }

		}
    static   deleteSmartphone(id) async {
    	
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse('http://192.168.2.130:4000/graphql'));
      request.body = '''{"query":"  mutation { deleteSmartphone(id :\\"$id\\")\\r\\n  {id brand Display_Quality Screen_Size Camera Storage Battery }\\r\\n}","variables":{}}''';

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
  deletephone=true;
	//	print(await response.stream.bytesToString());
      }
      else {
		  //print(response.reasonPhrase);
      }

		  }

    static Stream<List<Smartphone>> getAllSmartphones() async* {
   

    yield* Stream.periodic(const Duration(milliseconds: 300), (_) async {
     var headers = {'Content-Type': 'application/json'};
		var request = http.Request('GET', Uri.parse('http://192.168.2.130:4000/graphql'));

		request.body = '''{"query":"query {Smartphones {id brand Display_Quality Screen_Size Camera Storage Battery Operating_System}}","variables":{}}'''; 
		request.headers.addAll(headers);
	  http.StreamedResponse response = await request.send();

    final body=jsonDecode(await response.stream.bytesToString());
	  final decodedJson = body["data"]["Smartphones"];
     List<Smartphone> smartphones ;

    if (response.statusCode == 200) {
      smartphones=decodedJson.map<Smartphone>(Smartphone.fromJson).toList();
      
       if (smartphones.isEmpty) {
      return smartphones;
       }
       else
     {return  decodedJson.map<Smartphone>(Smartphone.fromJson).toList();}
    }

    }   
    
    ).asyncMap(
      (value) async => await value,
    );
  }
   
}	


  


