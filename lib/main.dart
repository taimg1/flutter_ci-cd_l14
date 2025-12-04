import 'package:flutter/material.dart';
import 'package:l13/config/app_config.dart';

void main() {
  // Print configuration на старті
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
        colorScheme: ColorScheme.fromSeed(seedColor: _getEnvironmentColor()),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }

  Color _getEnvironmentColor() {
    switch (AppConfig.environment) {
      case BuildEnvironment.dev:
        return Colors.blue;
      case BuildEnvironment.staging:
        return Colors.orange;
      case BuildEnvironment.prod:
        return Colors.green;
    }
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
              Icon(
                _getEnvironmentIcon(),
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
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
              const SizedBox(height: 8),
              Text(
                'API Version: ${AppConfig.apiVersion}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Timeout: ${AppConfig.apiTimeout}s',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              if (AppConfig.enableDebugFeatures)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.amber.shade700),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bug_report, color: Colors.amber),
                      SizedBox(width: 8),
                      Text('Debug Features Enabled'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showConfigDialog(context);
        },
        child: const Icon(Icons.info),
      ),
    );
  }

  IconData _getEnvironmentIcon() {
    switch (AppConfig.environment) {
      case BuildEnvironment.dev:
        return Icons.developer_mode;
      case BuildEnvironment.staging:
        return Icons.science;
      case BuildEnvironment.prod:
        return Icons.rocket_launch;
    }
  }

  void _showConfigDialog(BuildContext context) {
    final config = AppConfig.toJson();
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Full Configuration'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: config.entries.map((entry) {
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
