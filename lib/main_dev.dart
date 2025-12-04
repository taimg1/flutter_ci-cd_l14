import 'package:flutter/material.dart';
import 'package:l13/config/app_config.dart';

void main() {
  // Force dev environment
  assert(() {
    // ignore: avoid_print
    print('🔧 Starting in DEVELOPMENT mode');
    return true;
  }());

  AppConfig.printConfig();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.appName),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.developer_mode, size: 100, color: Colors.blue),
              const SizedBox(height: 24),
              Text(
                'Environment: ${AppConfig.environmentName}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'API URL: ${AppConfig.apiBaseUrl}',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade700),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.bug_report, color: Colors.blue),
                    SizedBox(height: 8),
                    Text('Development Mode'),
                    Text('Debug features enabled'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showConfigDialog(context);
        },
        icon: const Icon(Icons.info),
        label: const Text('Config'),
      ),
    );
  }

  void _showConfigDialog(BuildContext context) {
    final config = AppConfig.toJson();
    showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Development Configuration'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children:
                    config.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text('${entry.key}: ${entry.value}'),
                      );
                    }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }
}
