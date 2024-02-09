import 'package:flutter/material.dart';
import 'package:googleapis/dialogflow/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ButtonJ extends StatelessWidget {
  const ButtonJ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.blue[100],
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.chat,
            color: Colors.black87,
          ),
          onPressed: () {
            prueba();
          },
        ),
      ),
    );
  }
}

void prueba() async {
  //read from json file

  String jsonString =
      await rootBundle.loadString('assets/ihc-voice-app-9c2846892f7a.json');

  // Decodifica el JSON a un mapa
  Map<String, dynamic> jsonMap = json.decode(jsonString);

  // Pasa el mapa a la función fromJson
  final credentials = ServiceAccountCredentials.fromJson(jsonMap);
  final httpClient = await clientViaServiceAccount(
      credentials, ['https://www.googleapis.com/auth/cloud-platform']);

  DialogflowApi dialogflowApi = DialogflowApi(httpClient, rootUrl:'https://us-central1-dialogflow.googleapis.com/');
  // print(httpClient.credentials.accessToken.data);

  //dialogflowapi
  print("before intent");
  GoogleCloudDialogflowCxV3DetectIntentResponse response =
      await dialogflowApi.projects.locations.agents.sessions.detectIntent(
          GoogleCloudDialogflowCxV3DetectIntentRequest.fromJson({
            "queryInput": {
              "text": {"text": "hola"},
              "languageCode": "en"
            },
            "queryParams": {"timeZone": "America/Barbados"}
          }),
          "projects/ihc-voice-app/locations/us-central1/agents/d76a9b06-4647-45c0-a246-f320496b08bd/sessions/1234567891");
  print(response.queryResult!.responseMessages?[0].text!.text?[0]);

}
