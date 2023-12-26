import 'package:flutter/material.dart';
import 'package:mqtt_demo/services/mqtt_service.dart';

import 'widgets/publish_message_dialogue.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MqttHandler mqttHandler = MqttHandler();

  @override
  void initState() {
    super.initState();
    mqttHandler.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Data received:',
                style: TextStyle(color: Colors.black, fontSize: 24)),
            ValueListenableBuilder<String>(
              builder: (BuildContext context, String value, Widget? child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 32,
                      ),
                    ),
                  ],
                );
              },
              valueListenable: mqttHandler.data,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // create a dialog to publish a message
          showDialog(
            context: context,
            builder: (context) {
              return PublishMessageDialogue(mqttHandler: mqttHandler);
            },
          );
        },
        tooltip: 'Publish',
        child: const Icon(Icons.send),
      ),
    );
  }
}
