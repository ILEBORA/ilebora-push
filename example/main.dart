import 'dart:convert';

import 'package:ilebora_push/ilebora_push.dart';

void main() async {
	Uri uri = Uri.parse('https//:...'); //Your events server url
	Map<String, dynamic> params = {}; //...parameters

	BoraPushClient 
		boraPushClient = BoraPushClient.connect(
			uri:  uri.replace(queryParameters: params),
			withCredentials:true,
			closeOnError:true,
		);

	Stream 
		myStream = boraPushClient.stream;
		myStream.listen((value) {
			try{
				//Conert to JSON
				var jsonResp = jsonDecode(value); 
				//Do something with the response

				print(jsonResp);
				
			}catch(e){
				//Do something on erro
			}
		});
}
