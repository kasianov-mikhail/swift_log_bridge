import 'package:flutter/material.dart';
import 'package:swift_log_bridge/swift_log_bridge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('swift-log Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  const logger = Logger('Example');
                  logger.info('Button tapped');
                },
                child: const Text('Log Info'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  const logger = Logger('Example');
                  logger.error(
                    'Something went wrong',
                    metadata: {'code': '42'},
                  );
                },
                child: const Text('Log Error'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
