import 'package:flutter/material.dart';

import '../../services/mqtt_service.dart';

class PublishMessageDialogue extends StatelessWidget {
  final MqttHandler mqttHandler;

  const PublishMessageDialogue({super.key, required this.mqttHandler});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return AlertDialog(
      title: const Text('Publish'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Message',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // publish the message
            mqttHandler.publishMessage(controller.text);

            Navigator.pop(context);
          },
          child: const Text('Publish'),
        ),
      ],
    );
  }
}
